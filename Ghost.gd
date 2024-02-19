extends CharacterBody2D

enum GhostState {
	IDLE,
	CHASING,
	TRANCE
}

var state = GhostState.IDLE
var target_position = Vector2.ZERO
var player_position
var speed = 75
var chasing_timer = 0
var trance_duration = 16000
var direction_to_player

var acceleration = 9

var max_acceleration = 500.0 
var current_velocity = Vector2.ZERO

var scale_change_interval = 2.0  # Time interval for texture scaling change (1 second)
var scale_change_timer = 0.0

@onready var player = get_parent().get_node("playerone")
@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready():
	var initial_positions = [
		Vector2(1240, -1492),
		Vector2(2334, -1495),
		Vector2(2736, -434),
		Vector2(2923, -895),
		Vector2(3078, 312)
	]
	var random_index = randi() % initial_positions.size()
	position = initial_positions[random_index]
	$ambience.play()

func _process(delta):
	player_position = player.position
	direction_to_player = (player.position - position).normalized()
	match state:
		GhostState.IDLE:
			update_idle_state(delta)
		GhostState.CHASING:
			update_chasing_state(delta)
#			chase_target(delta)
		GhostState.TRANCE:
			update_chasing_state(delta)
			
func _on_detection_area_body_entered(body):
	if body.name == "playerone":
		print("Detected:", body.name)
		state = GhostState.CHASING
		chasing_timer = 0
		$AnimationPlayer.play("horror-blink")
		$Choir.play()
		var r = randf_range(0,3)
		if r > 1.5:
			$riser.play()
		else:
			$breath.play()
			
		get_node("PointLight2D").visible = true
	
func _on_detection_area_body_exited(body):
	if $fastbreath.is_inside_tree():
		print("get kicked")
		if body.name == "playerone":
			$riser.stop()
			$fastbreath.play()
	#		$breath.stop()
			$AnimationPlayer.play("RESET")
			state = GhostState.IDLE
			player.get_node("light").texture_scale = 1.65
			get_node("PointLight2D").visible = false
			

func update_idle_state(delta):
	# Implement random movement or idle behavior here
	# For simplicity, let's move the ghost randomly
#	var direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
#	direction = direction.normalized()
#	velocity = direction * speed * delta
	nav.target_position = player_position
	
	var direction = nav.get_next_path_position() - position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed * 0.5, acceleration * 5 * delta)
	
	move_and_slide()
	
	velocity = Vector2.ZERO
	move_and_slide()
	
#func chase_target(delta):
#	var look     = get_node("RayCast2D")
#	look.cast_to = (player.position - position).normalized()
#	look.force_raycast_update()
#
#  # if we can see the target, chase it
#	if !look.is_colliding():
#		direction_to_player = look.cast_to.normalized()
#
#  # or chase first scent we can see
#	else:
#		for scent in player.target.scent_trail:
#			look.cast_to = (scent.position - position)
#			look.force_raycast_update()
#
#			if !look.is_colliding():
#				direction_to_player = look.cast_to.normalized()
#				break
#	velocity = direction_to_player * speed
#
#	move_and_slide()
	

func update_chasing_state(delta):
	print("player:", player_position)
	print("ghost:", position)
	var playerDied = false
	if sqrt( (player_position.x - position.x)**2 + (player_position.y - position.y)**2 ) < 1:
		playerDied = true
	if player.get_node("light").texture_scale < 0.1 or playerDied:
		$ambience.stop()
		$Scream.play()
		get_viewport().set_input_as_handled()
		get_tree().change_scene_to_file("res://gameover.tscn")
	
	if player.get_node("light").texture_scale < 0.5:
		$Scream.play()
		
	nav.target_position = player_position
	
	var direction = nav.get_next_path_position() - position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed * 1.33, (acceleration+40) * delta)
	
	move_and_slide()

#	# Smoothly accelerate towards the direction
#	var target_velocity = direction_to_player * speed
#	var acceleration = (target_velocity - current_velocity) * max_acceleration

#	velocity += acceleration * delta

#	if velocity.length() > speed:
#		velocity = velocity.normalized() * speed
	
	scale_change_timer += delta
	
	if scale_change_timer >= scale_change_interval:
		scale_change_timer -= scale_change_interval
		player.get_node("light").texture_scale /= 2.12

	chasing_timer += delta
	if chasing_timer > trance_duration:
		state = GhostState.TRANCE

func update_trance_state(delta):
	# Maintain the same direction of movement
	velocity = velocity.normalized() * speed
	move_and_slide()
