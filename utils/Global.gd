extends Node

enum EnemyType {ALIEN, UFO}
enum Scenes {START_MENU, HIGH_SCORES, GAME, LEVEL_SELECT}
enum Levels {TEST_LEVEL}

const SceneMap = {
	Scenes.START_MENU: "res://scenes/start/StartMenu.tscn",
	Scenes.HIGH_SCORES: "res://scenes/highscores/HighScoreMenu.tscn",
	Scenes.GAME: "res://scenes/game/GameScene.tscn"
}

const LevelMap = {
	Levels.TEST_LEVEL: "res://scenes/game/level/TestLevel.tscn"
}

var main : Main = null
var debug = true
var time_of_day = 0.0;

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
	
