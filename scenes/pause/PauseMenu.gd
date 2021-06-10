extends Control


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_pause(!get_tree().paused)
	
func _pause(shouldPause):
	get_tree().paused = shouldPause
	visible = shouldPause

func _on_ResumeButton_pressed():
	_pause(false)

func _on_SettingsButton_button_up():
	$"../SettingsMenu".visible = true

func _on_QuitMenuButton_pressed():
	self.visible = false
	
