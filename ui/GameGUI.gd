extends Control

onready var score_number = $Container/Counters/ScoreCounter/Number
onready var life_number = $Container/Counters/LiveCounter/Number

var score = 0

func _ready():
	var player_lives = $"../../Player".lives
	EventManager.connect("player_hurt", self, "_Event_player_hurt")
	EventManager.connect("player_lost", self, "_Event_player_lost")
	EventManager.connect("enemy_died", self, "_Event_enemy_died")
	life_number.text = str(player_lives)
	score_number.text = str(score)

func _Event_enemy_died(_type, value):
	score += value
	score_number.text = str(score)

func _Event_player_hurt(lives):
	life_number.text = str(lives)

func _Event_player_lost():
	pass
