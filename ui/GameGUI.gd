extends Control

onready var score_number = $Container/Counters/ScoreCounter/Number
onready var life_number = $Container/Counters/LiveCounter/Number

var score = 0

func _ready():
	var player_lives = $"../Characters/Player".lives
	EventManager.connect("player_died", self, "_on_Event_player_died")
	EventManager.connect("enemy_died", self, "_on_Event_enemy_died")
	life_number.text = str(player_lives)
	score_number.text = str(score)

func _on_Event_enemy_died(_type, value):
	score += value
	score_number.text = str(score)

func _on_Event_player_died(lives):
	life_number.text = str(lives)
