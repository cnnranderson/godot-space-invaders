extends Position2D

var amount = 0

func _ready():
	$Label.text = str(amount)
	
	$Tween.interpolate_property(self, "scale",
		scale, Vector2(2.0, 2.0), 0.2,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	$Tween.interpolate_property(self, "scale",
		Vector2(2.0, 2.0), Vector2(0.3, 0.3), 0.7,
		Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	
	$Tween.interpolate_property(self, "modulate:a", 1, 0, 0.7,
		Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	
	$Tween.interpolate_property(self, "position:y",
		position.y, position.y - 10, 1,
		Tween.TRANS_SINE, Tween.EASE_OUT)
	
	$Tween.start()

func _on_Tween_tween_all_completed():
	queue_free()
