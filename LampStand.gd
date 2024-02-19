extends Sprite2D

var played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("flicker")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if not played and body.name == "playerone":
		$crescendo.play()
		played = true
	pass # Replace with function body.
