extends CharacterBody2D

enum GhostState {
	IDLE,
	CHASING,
	TRANCE
}

var state = GhostState.CHASING
var target_position = Vector2.ZERO
var player_position
var speed = 75
var chasing_timer = 0
var trance_duration = 16000
var direction_to_player

var max_acceleration = 500.0 
var current_velocity = Vector2.ZERO

var scale_change_interval = 2.0  # Time interval for texture scaling change (1 second)
var scale_change_timer = 0.0

@onready var player = get_parent().get_node("playerone")

func _ready():
	pass


func _process(delta):
	player_position = player.position
	direction_to_player = (player.position - position).normalized()
	match state:
		GhostState.IDLE:
			update_idle_state(delta)
		GhostState.CHASING:
			update_chasing_state(delta)
		GhostState.TRANCE:
			update_chasing_state(delta)
			
func _on_detection_area_body_entered(body):
	print("Detected:", body.name)
	state = GhostState.CHASING
	chasing_timer = 0
	$AnimPlayer.play("horror-blink")
	
func _on_detection_area_body_exited(body):
	if body.name == "playerone":
		$AnimPlayer.play("RESET")
		state = GhostState.IDLE
		player.get_node("light").texture_scale = 1

func update_idle_state(delta):
	# Implement random movement or idle behavior here
	# For simplicity, let's move the ghost randomly
#	var direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
#	direction = direction.normalized()
#	velocity = direction * speed * delta
	
	velocity = Vector2.ZERO
	move_and_slide()

func update_chasing_state(delta):
	
	if player.get_node("light").texture_scale < 0.1:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")

	# Smoothly accelerate towards the direction
	var target_velocity = direction_to_player * speed
	var acceleration = (target_velocity - current_velocity) * max_acceleration

	velocity += acceleration * delta

	if velocity.length() > speed:
		velocity = velocity.normalized() * speed
	
	scale_change_timer += delta
	
	if scale_change_timer >= scale_change_interval:
		scale_change_timer -= scale_change_interval
		player.get_node("light").texture_scale /= 1.5

	move_and_slide()

	chasing_timer += delta
	if chasing_timer > trance_duration:
		state = GhostState.TRANCE

func update_trance_state(delta):
	# Maintain the same direction of movement
	velocity = velocity.normalized() * speed
	move_and_slide()
