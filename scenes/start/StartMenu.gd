extends Control

onready var game_name = $BaseContainer/GameName
onready var update_news = $BaseContainer/MainContainer/UpdateNewsContainer/Label
onready var title_tween = [game_name.rect_position.y, game_name.rect_position.y + 10]

var misc_titles = [
	"New stuff!",
	"Protect your space!",
	"Campaign coming soon!",
	"Paracausal mode coming soon!"
]

func _ready():
	_tween_title()
	_rotate_news()
	EventManager.emit_signal("daytime_change", 0, 2)

func _tween_title():
	$Tween.interpolate_property(game_name, "rect_position:y",
		title_tween[0], title_tween[1], 2,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _rotate_news():
	update_news.text = misc_titles[randi() % misc_titles.size()]

func _on_Tween_tween_completed(object, key):
	title_tween.invert()
	_tween_title()

func _on_PlayButton_pressed():
	return get_tree().change_scene("res://scenes/GameScene.tscn")

func _on_ScoreButton_pressed():
	Global.main.load_scene(Global.main.Scenes.HIGH_SCORES)

func _on_SettingsButton_pressed():
	Global.main.show_settings(true)

func _on_QuitButton_pressed():
	get_tree().quit()
