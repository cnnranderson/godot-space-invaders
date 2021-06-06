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
		config.set_value("audio", "music", GlobalManager.audio.music)
		config.set_value("audio", "sfx", GlobalManager.audio.sfx)
		config.set_value("audio", "mute", GlobalManager.audio.mute)
	config.save(SETTINGS_FILE)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE)
	if err == OK:
		GlobalManager.audio.music = config.get_value("audio", "music", -15.0)
		GlobalManager.audio.sfx = config.get_value("audio", "sfx", -20.0)
		GlobalManager.audio.mute = config.get_value("audio", "mute", false)

func save():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var err = file.open(save_path, File.WRITE)
	if err == OK:
		file.store_var(GlobalManager.high_scores)
		file.close()
		
	print("Saved")

func load_dat():
	var file = File.new()
	if file.file_exists(save_path):
		var err = file.open(save_path, File.READ)
		if err == OK:
			GlobalManager.high_scores = file.get_var()
			file.close()
	
	print(GlobalManager.high_scores)
	print("Loaded")

func startup_load():
	load_dat()
	load_settings()
