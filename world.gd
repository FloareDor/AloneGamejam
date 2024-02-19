extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer2/PauseMenu.hide()
	pass # Replace with function body.

func pause():
	get_tree().paused = true
	$heartbeat.play()
	$CanvasLayer2/PauseMenu.show()
	
func unpause():
	get_tree().paused = false
	$heartbeat.play()
	$CanvasLayer2/PauseMenu.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause()

func _on_continue_pressed():
	unpause()
	pass # Replace with function body.


func _on_giveup_pressed():
	get_tree().quit() # Replace with function body.


func _on_what_body_entered(body):
	pass # Replace with function body.
