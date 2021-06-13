extends Node2D

var level = null

func _ready():
	# Make sure we have everything ready
	_init_level()
	$Hud/YouWin.visible = false
	EventManager.connect("game_won", self, "_Event_game_won")

func _input(event):
	if Input.is_action_just_pressed("pause"):
		Global.main.show_pause(!get_tree().paused)

func _init_level():
	level = load(Global.LevelMap[Global.main.curr_level]).instance()
	$Level.add_child(level)

func _on_DayTimer_timeout():
	if Global.time_of_day + 2 > 24:
		Global.time_of_day = 0
	EventManager.emit_signal("daytime_change", Global.time_of_day + 2, 2.0)
	$Timers/DayTimer.start()
