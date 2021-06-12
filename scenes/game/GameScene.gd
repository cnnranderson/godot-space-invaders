extends Node2D

var level

func _ready():
	# Make sure we have everything ready
	assert(Global.main and Global.main.curr_level)
	_init_level()
	$YouWin.visible = false
	EventManager.connect("game_won", self, "_Event_game_won")

func _input(event):
	if Input.is_action_just_pressed("pause"):
		Global.main.show_pause(!get_tree().paused)

func _init_level():
	level = load(Global.main.curr_level)
	$Level.add_child(level)

