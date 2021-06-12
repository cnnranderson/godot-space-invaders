tool
extends SubdivideSprite

func _ready():
	print("started")
	EventManager.connect("daytime_change", self, "_Event_daytime_changed")
	EventManager.connect("daytime_pause", self, "_Event_daytime_pause")

func _Event_daytime_pause(should_pause: bool):
	VisualServer.set_shader_time_scale(0.0 if should_pause else 1.0)

func _Event_daytime_changed(timeOfDay, delay = 0.0):
	$Tween.interpolate_property(material, "shader_param/TimeOfDay",
		Global.time_of_day, timeOfDay, delay,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	Global.time_of_day = timeOfDay
	$Tween.start()
