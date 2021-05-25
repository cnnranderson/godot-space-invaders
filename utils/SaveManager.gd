extends Node

const SAVE_DIR = "user://saves/"

var save_path = "save.dat"

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func save():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(GlobalManager.high_scores)
		file.store_var(GlobalManager.options)
		file.close()
		
	print("Saved")

func load():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			GlobalManager.high_scores = file.get_var()
			GlobalManager.options = file.get_var()
			file.close()
	
	print("Loaded")
	print(GlobalManager.high_scores)
	print(GlobalManager.options)
