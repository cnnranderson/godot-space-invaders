extends Node

enum EnemyType {ALIEN, UFO}

var main = null
var debug = true

onready var time_of_day = 0.0;

# TODO: Maybe move this into a game state or data manager?
onready var high_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
onready var audio = {
	"music": -15.0,
	"sfx": -20.0,
	"mute": false
}

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	SaveManager.startup_load()

func _process(_delta):
	if debug:
		# Easy exit
		if Input.is_action_pressed("debug_quit"):
			get_tree().quit()
	
