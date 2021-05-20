extends Node

func play_sound(sound: String):
	var player = AudioStreamPlayer.new()
	player.stream = load(sound)
	player.connect("finished", player, "queue_free")
	add_child(player)
	player.play()

func play_sound_2d(sound: String, pos: Vector2):
	var player = AudioStreamPlayer2D.new()
	player.position = pos
	player.stream = load(sound)
	player.connect("finished", player, "queue_free")
	add_child(player)
	player.play()
