tool
extends SubdivideSprite

func _ready():
	EventManager.connect("daytime_change", self, "_daytime_changed")
	
func _daytime_changed(timeOfDay, delay = 0.0):
	print("Setting time of day to: " + str(timeOfDay))
	$Tween.interpolate_property(material, "shader_param/TimeOfDay",
		GlobalManager.time_of_day, timeOfDay, delay,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	GlobalManager.time_of_day = timeOfDay
	$Tween.start()
