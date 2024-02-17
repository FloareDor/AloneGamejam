extends Label

var keyGoal = 4
var keysCollected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
#	var red = Color(1.0,0.0,0.0,1.0)
#	set("theme_override_colors/font_color",red)
	text = "Keys Collected: " + str(keysCollected) + "/" + str(keyGoal)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_2_body_entered(body):
	if body.name == "Key":
		keysCollected+=1
		print("keysCollected:", keysCollected)
		text = "Keys Collected: " + str(keysCollected) + "/" + str(keyGoal)
	pass # Replace with function body.


#func _on_area_2d_2_body_entered(body):
#	pass # Replace with function body.
