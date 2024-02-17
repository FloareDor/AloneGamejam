extends Node2D

var playerInsideZone = false
var isUp = false
var doorOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("t") and playerInsideZone and not doorOpen:
		if isUp:
			$AnimationPlayer.play("door-open-up")
			doorOpen = true
		else:
			$AnimationPlayer.play("door-open-down")
			doorOpen = true
		$doorOpen.play()
	pass

func _on_area_2d_body_entered(body):
#	print("body.name:", body.name)
	if body.name == "playerone":
		playerInsideZone = true
		print("door area")
		if body.global_position.y > global_position.y:
			isUp = true
		elif body.global_position.y < global_position.y:
			isUp = false
	pass


func _on_area_2d_body_exited(body):
	if body.name == "playerone":
		playerInsideZone = false
		if body.global_position.y > global_position.y and doorOpen:
			$AnimationPlayer.play("door-close-down")
			doorOpen = false
		elif body.global_position.y < global_position.y and doorOpen:
			$AnimationPlayer.play("door-close-up")
			doorOpen = false
	pass # Replace with function body.
