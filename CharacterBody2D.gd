extends CharacterBody2D

var SPEED = 300.0
const JUMP_VELOCITY = -400.0
# var velocity = Vector2()

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 0

var keysCollected = 0
const keyGoal = 4

var runDuration = 0
	
func _physics_process(delta):
	
	SPEED = 300.0
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_vector = Vector2()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if Input.is_action_just_pressed("z"):
		SPEED = SPEED + 4000

	if input_vector.length() > 1:
		input_vector = input_vector.normalized()
#	print(input_vector)

	velocity.x = input_vector.x * SPEED
	velocity.y = input_vector.y * SPEED
	
	runDuration += delta
	
	update_animation(input_vector, runDuration)
	
	move_and_slide()
	
func gotKey():
	keysCollected+=1
#	get_parent().get_node("CanvasLayer2/lbl").text = "Keys to be found: " + str(keyGoal - keysCollected)
	if keysCollected >= keyGoal:
		get_tree().change_scene_to_file("res://won.tscn")
	else:
		$keysound.play()
	
func update_animation(input_vector, runDuration):
#	get_parent().get_node("CanvasLayer2/lbl").text = "Keys to be found: " + str(keyGoal - keysCollected)
	if input_vector.length() > 0.1:  # Adjust threshold as needed
		if abs(input_vector.x) > abs(input_vector.y):
			if input_vector.x > 0:
				$AnimationPlayer.play("right")
			else:
				$AnimationPlayer.play("left")
		else:
			if input_vector.y > 0:
				$AnimationPlayer.play("down")
			else:
				$AnimationPlayer.play("up")
		if int(runDuration)%6 == 0 and runDuration != 0 :
			$slowBreath.play()
	
	else:
		$AnimationPlayer.stop()
#		runDuration = 0.1
#		if int(runDuration)%6 == 0 and runDuration != 0:
#			$slowBreath.play()
#		$slowBreath.play()
#		$AnimationPlayer.play("idle")


func _on_area_2d_body_entered(body):
	if body.name == "Key":
		gotKey()
	elif body.name == "Key2":
		get_node("light").texture_scale = 2.8
	pass # Replace with function body.
