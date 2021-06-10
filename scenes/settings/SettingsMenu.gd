extends Control

onready var saved_label = $Container/ActionButtons/SavedLabel
onready var music_label = $Container/Settings/Music/MusicLabel
onready var music_slider = $Container/Settings/Music/MusicSlider
onready var sfx_label = $Container/Settings/Sfx/SfxLabel
onready var sfx_slider = $Container/Settings/Sfx/SfxSlider

var volume_label = "{type} Volume: ({val}%)"

func _ready():
	music_slider.value = Global.audio.music
	sfx_slider.value = Global.audio.sfx

func _on_MusicSlider_value_changed(value):
	music_label.text = volume_label.format({"type": "Music", "val": "%0*d" % [2, value]})

func _on_SfxSlider_value_changed(value):
	sfx_label.text = volume_label.format({"type": "Sfx", "val": "%0*d" % [2, value]})

func _on_SaveButton_pressed():
	Global.audio.music = music_slider.value
	Global.audio.sfx = sfx_slider.value
	SaveManager.save_settings()
	$Tween.interpolate_property(saved_label, "modulate:a", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_CloseButton_pressed():
	Global.main.show_settings(false)
