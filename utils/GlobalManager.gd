extends Node

enum EnemyType {ALIEN, UFO}

onready var options = {
	"sound_sfx": -10.0,
	"sound_music": 0.0
}

onready var high_scores = {
	1: 0,
	2: 0,
	3: 0,
	4: 0,
	5: 0,
	6: 0,
	7: 0,
	8: 5,
	9: 0,
	10: 0
}

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	SaveManager.load()
	randomize()

func _process(delta):
	if Input.is_action_pressed("debug_quit"):
		get_tree().quit()
	
