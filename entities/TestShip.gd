extends Player

var firing = false

func _fire():
	# Change the wing that's firing and add tween effect
	firing = !firing
	var wing = $Wings/Left if firing else $Wings/Right
	$Tween.interpolate_property(wing, "position:y", -10, -3, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property(wing, "position:y", -3, -10, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
		
	bullet_time = bullet_wait_time
	var bullet = _Bullet.instance()
	bullet.source = "player"
	bullet.position = position + (wing.position * scale)
	bullet.dir = -1
	
	# get_tree().root.get_node("Main").call_deferred("add_child", bullet)
	$"../Effects".add_child(bullet)
	SoundManager.play_sound_2d(SoundManager.SoundType.SFX, LaserSound, position)

func _on_TestPlayer_area_entered(area):
	._on_Player_area_entered(area)

func _on_TestPlayer_body_entered(body):
	._on_Player_body_entered(body)
