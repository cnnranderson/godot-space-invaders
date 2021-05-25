extends Node

enum SoundType {SFX, MUSIC}

func play_sound(sound: String):
	var player = AudioStreamPlayer.new()
	player.stream = load(sound)
	player.connect("finished", player, "queue_free")
	add_child(player)
	player.play()

func play_sound_2d(type, sound: String, pos: Vector2):
	assert(type in SoundType.values())
	var player = AudioStreamPlayer2D.new()
	player.position = pos
	player.stream = load(sound)
	player.connect("finished", player, "queue_free")
	add_child(player)
	
	# Match volume to set level
	match type:
		SoundType.SFX:
			player.volume_db = GlobalManager.options.sound_sfx
		SoundType.MUSIC:
			player.volume_db = GlobalManager.options.sound_music
		_:
			player.volume_db = GlobalManager.options.sound_music
	
	player.play()
