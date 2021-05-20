extends Control

onready var title_tween = [$MarginContainer/GameName.rect_position.y, $MarginContainer/GameName.rect_position.y + 10]

func _ready():
	_tween_title()

func _tween_title():
	$Tween.interpolate_property($MarginContainer/GameName, "rect_position:y", title_tween[0], title_tween[1], 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_PlayButton_button_up():
	var _switch = get_tree().change_scene("res://scenes/GameScene.tscn")

func _on_QuitButton_button_up():
	get_tree().quit()

func _on_Tween_tween_completed(object, key):
	title_tween.invert()
	_tween_title()
