extends Node2D

enum Scenes {START_MENU, GAME, HIGH_SCORES}

const SceneMap = {
	Scenes.START_MENU: "res://scenes/start/StartMenu.tscn",
	Scenes.HIGH_SCORES: "res://scenes/highscores/HighScoreMenu.tscn"
}

func _ready():
	Global.main = self
	load_scene(Scenes.START_MENU)
	pass

func load_scene(scene):
	# Validate scene
	assert(scene in Scenes.values())
	
	# Pause any happenings
	get_tree().paused = true
	
	# Load the new scene
	print("LOADING Scene: %s" % scene)
	var children = $Scene.get_children()
	if not children.empty():
		children[0].queue_free()
	var new_scene = load(SceneMap[scene]).instance()
	$Scene.add_child(new_scene)
	
	# Unpause the tree to continue with the scene
	get_tree().paused = false
	print("FINISHED LOADING Scene: %s" % scene)

func show_pause(visible: bool):
	get_tree().paused = visible
	$MenuLayer/PauseMenu.visible = visible

func show_settings(visible: bool):
	$MenuLayer/SettingsMenu.visible = visible
