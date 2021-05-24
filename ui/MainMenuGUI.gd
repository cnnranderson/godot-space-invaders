extends Control

onready var game_name = $BaseContainer/GameName
onready var update_news = $BaseContainer/MainContainer/UpdateNewsContainer/Label
onready var title_tween = [game_name.rect_position.y, game_name.rect_position.y + 10]

var misc_titles = [
	"New stuff!",
	"Protect your spice!",
	"Campaign coming soon!",
	"Paracausal mode coming soon!"
]

func _ready():
	_tween_title()
	_rotate_news()

func _tween_title():
	$Tween.interpolate_property(game_name, "rect_position:y",
		title_tween[0], title_tween[1], 2,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _rotate_news():
	update_news.text = misc_titles[randi() % misc_titles.size()]

func _on_PlayButton_button_up():
	var _switch = get_tree().change_scene("res://scenes/GameScene.tscn")

func _on_QuitButton_button_up():
	get_tree().quit()

func _on_Tween_tween_completed(object, key):
	title_tween.invert()
	_tween_title()
