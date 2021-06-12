extends Node2D

var current_level : Level = null

func _ready():
	# Make sure we have everything ready
	assert(Global.main and Global.main.selected_level)
	_init_level()
	
	$Enemies/UfoTimer.wait_time = randi() % 16 + 20
	$YouWin.visible = false

func _input(event):
	if Input.is_action_just_pressed("pause"):
		Global.main.show_pause(!get_tree().paused)

func _init_level():
	current_level = Global.main.selected_level
	current_level.init()
