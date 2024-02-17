extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Generate random x and y positions within the specified ranges
	var x_position = randf_range(250, 3000)
	var y_position = randf_range(-1000, -500)
	
	# Set the position of the keys
	global_position = Vector2(x_position, y_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	print("bodygaurd:", body.name)
	if body.name == "playerone":
		queue_free()
