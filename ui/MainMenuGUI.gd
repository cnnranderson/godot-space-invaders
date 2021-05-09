extends Control

func _on_PlayButton_button_up():
	var _switch = get_tree().change_scene("res://scenes/GameScene.tscn")

func _on_QuitButton_button_up():
	get_tree().quit()
