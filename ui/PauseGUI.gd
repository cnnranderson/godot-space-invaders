extends Control

const iSettings = preload("res://ui/SettingsMenuGUI.tscn")

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_pause(!get_tree().paused)
	
func _pause(shouldPause):
	get_tree().paused = shouldPause
	visible = shouldPause

func _on_ResumeButton_pressed():
	_pause(false)

func _on_SettingsButton_button_up():
	var settings = iSettings.instance()
	get_tree().get_root().add_child(settings)

func _on_QuitMenuButton_pressed():
	_pause(false)
	var _switch = get_tree().change_scene("res://scenes/MainMenuScene.tscn")
