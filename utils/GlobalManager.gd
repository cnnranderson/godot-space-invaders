extends Node

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()

func _process(delta):
	if Input.is_action_pressed("debug_quit"):
		get_tree().quit()
	
