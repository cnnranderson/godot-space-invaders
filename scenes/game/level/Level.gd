extends Node2D
class_name Level

export(bool) var has_ufo = false
export(int) var enemy_count = 0
export(int) var wave_count = 0

# TODO: 
# - Win condition types?
# - Starting height for waves
# - Enemy types for waves
# - 

func _ready():
	EventManager.connect("enemy_died", self, "_on_Event_enemy_died")
	EventManager.connect("game_won", self, "_on_Event_game_won")

func init():
	pass
