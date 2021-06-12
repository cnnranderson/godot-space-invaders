extends Control

func _on_ResumeButton_pressed():
	Global.main.show_pause(false)

func _on_SettingsButton_pressed():
	Global.main.show_settings(true)

func _on_QuitMenuButton_pressed():
	Global.main.show_pause(false)
	Global.main.load_scene(Global.Scenes.START_MENU)

