extends Node2D

var curr_scene = Global.Scenes.START_MENU
var selected_level : Level = Level.new()

func _ready():
	Global.main = self
	load_scene(Global.Scenes.START_MENU)

func load_scene(scene):
	# Validate scene
	assert(scene in Global.Scenes.values())
	
	# Pause any happenings
	get_tree().paused = true
	
	# Load the new scene
	print("LOADING Scene: %s" % scene)
	var children = $Scene.get_children()
	if not children.empty():
		children[0].queue_free()
	var new_scene = load(Global.SceneMap[scene]).instance()
	curr_scene = scene
	$Scene.add_child(new_scene)
	
	# Unpause the tree to continue with the scene
	get_tree().paused = false

func show_pause(visible: bool):
	print("SHOW PAUSE: %s" % visible)
	get_tree().paused = visible
	$MenuLayer/PauseMenu.visible = visible

func show_settings(visible: bool):
	print("SHOW SETTINGS: %s" % visible)
	$MenuLayer/SettingsMenu.visible = visible
