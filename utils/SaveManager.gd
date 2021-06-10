extends Node

const SAVE_DIR = "user://saves/"
const SETTINGS_FILE = "user://settings.cfg"

var save_path = "save.dat"

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func save_settings():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE)
	if err == OK:
		config.set_value("audio", "music", Global.audio.music)
		config.set_value("audio", "sfx", Global.audio.sfx)
		config.set_value("audio", "mute", Global.audio.mute)
	config.save(SETTINGS_FILE)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE)
	if err == OK:
		Global.audio.music = config.get_value("audio", "music", -15.0)
		Global.audio.sfx = config.get_value("audio", "sfx", -20.0)
		Global.audio.mute = config.get_value("audio", "mute", false)

func save():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var err = file.open(save_path, File.WRITE)
	if err == OK:
		file.store_var(Global.high_scores)
		file.close()
		
	print("Saved")

func load_dat():
	var file = File.new()
	if file.file_exists(save_path):
		var err = file.open(save_path, File.READ)
		if err == OK:
			Global.high_scores = file.get_var()
			file.close()
	
	print(Global.high_scores)
	print("Loaded")

func startup_load():
	load_dat()
	load_settings()
