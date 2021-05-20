extends Enemy

func _custom_movement(delta):
	position.x += cur_speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
