extends Node2D

var playerInsideZone = false
var isLeft = false
var doorOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("t") and playerInsideZone and not doorOpen:
		if isLeft:
			$AnimationPlayer.play("door-open-left")
			doorOpen = true
		else:
			$AnimationPlayer.play("door-open-right")
			doorOpen = true	
	pass


func _on_area_2d_body_entered(body):
	if body.name == "playerone":
		playerInsideZone = true
		print("door area")
		if body.global_position.x > global_position.x:
#			$AnimationPlayer.play("door-open-left")
			isLeft = true
		elif body.global_position.x < global_position.x:
#			$AnimationPlayer.play("door-open-right")
			isLeft = false
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.name == "playerone":
		playerInsideZone = false
		if body.global_position.x > global_position.x and doorOpen:
			$AnimationPlayer.play("door-close-right")
			doorOpen = false
		elif body.global_position.x < global_position.x and doorOpen:
			$AnimationPlayer.play("door-close-left")
			doorOpen = false
	pass # Replace with function body.
