extends Control

onready var score_list = $Container/VBoxContainer/ScrollContainer/ScoreList

func _ready():
	for i in range(0, Global.high_scores.size()):
		var score_record = Label.new()
		score_record.align = HALIGN_CENTER
		score_record.text = "%d : %d" % [i + 1, Global.high_scores[i]]
		score_list.add_child(score_record)

func _on_CloseButton_pressed():
	Global.main.load_scene(Global.main.Scenes.START_MENU)
