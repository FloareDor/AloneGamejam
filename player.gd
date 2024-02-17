extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

# Player properties
var speed = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the input vector
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# Normalize the input vector to prevent faster movement diagonally
	input_vector = input_vector.normalized()

	# Move the player
	move_and_slide(input_vector * speed)
