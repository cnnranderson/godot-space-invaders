extends Node

const Enemy := preload("res://entities/Enemy.tscn")

func _ready():
	_spawn_enemy_row(50, 1)
	_spawn_enemy_row(100, -1)
	_spawn_enemy_row(150, 1)
	_spawn_enemy_row(250, -1)

func _process(delta):
	if Input.is_action_pressed("debug_quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("debug_restart"):
		get_tree().reload_current_scene()

func _spawn_enemy_row(y, dir):
	for n in range(8):
		var enemy = Enemy.instance()
		enemy.position = Vector2(150 + (50 * n), y)
		enemy.dir = dir
		enemy.connect("enemy_died", $GameGUI, "_on_Enemy_enemy_died")
		$Characters.add_child(enemy)

