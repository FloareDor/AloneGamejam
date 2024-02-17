extends Button

@onready var redy = false
# Called when the node enters the scene tree for the first time.
func _ready():
	redy = true
	pass # Replace with function body.

func _pressed():
	if redy:
		get_tree().change_scene_to_file("res://scenes/start.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
