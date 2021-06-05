extends Control

const iSettings = preload("res://ui/SettingsMenuGUI.tscn")
const iHighscores = preload("res://ui/HighscoresMenuGUI.tscn")

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

func _on_PlayButton_button_up():
	return get_tree().change_scene("res://scenes/GameScene.tscn")

func _on_ScoreButton_button_up():
	var highscores = iHighscores.instance()
	get_tree().get_root().add_child(highscores)

func _on_SettingsButton_button_up():
	var settings = iSettings.instance()
	get_tree().get_root().add_child(settings)

func _on_QuitButton_button_up():
	get_tree().quit()

func _on_Tween_tween_completed(object, key):
	title_tween.invert()
	_tween_title()
