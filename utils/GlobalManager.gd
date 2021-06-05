extends Node

enum EnemyType {ALIEN, UFO}

onready var options = {
	"volume_sfx": -10.0,
	"volume_music": 0.0
}

onready var high_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

onready var time_of_day = 0.0;

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	SaveManager.load()
	randomize()

func _process(delta):
	if Input.is_action_pressed("debug_quit"):
		get_tree().quit()
	
