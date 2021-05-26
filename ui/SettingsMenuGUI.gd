extends Control

onready var saved_label = $SettingsContainer/ActionButtons/SavedLabel
onready var music_label = $SettingsContainer/Settings/Music/MusicLabel
onready var music_slider = $SettingsContainer/Settings/Music/MusicSlider
onready var sfx_label = $SettingsContainer/Settings/Sfx/SfxLabel
onready var sfx_slider = $SettingsContainer/Settings/Sfx/SfxSlider

var volume_label = "{type} Volume: ({val}%)"

func _ready():
	sfx_slider.value = GlobalManager.options.volume_sfx
	music_slider.value = GlobalManager.options.volume_music

func _on_MusicSlider_value_changed(value):
	music_label.text = volume_label.format({"type": "Music", "val": "%0*d" % [2, value]})

func _on_SfxSlider_value_changed(value):
	sfx_label.text = volume_label.format({"type": "Sfx", "val": "%0*d" % [2, value]})

func _on_SaveButton_button_up():
	GlobalManager.options.volume_music = music_slider.value
	GlobalManager.options.volume_sfx = sfx_slider.value
	SaveManager.save()
	$Tween.interpolate_property(saved_label, "modulate:a", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_CloseButton_button_up():
	queue_free()
