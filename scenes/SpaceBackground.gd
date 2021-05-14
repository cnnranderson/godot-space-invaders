extends TextureRect

func _process(delta):
	VisualServer.set_shader_time_scale(0.0 if get_tree().paused else 1.0)
