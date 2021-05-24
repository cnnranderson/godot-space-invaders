extends Control

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_pause(!get_tree().paused)
	
func _pause(shouldPause):
	get_tree().paused = shouldPause
	visible = shouldPause

func _on_ResumeButton_pressed():
	_pause(false)

func _on_QuitMenuButton_pressed():
	_pause(false)
	var _switch = get_tree().change_scene("res://scenes/MainMenuScene.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
