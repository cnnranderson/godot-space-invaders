extends Node

const Player := preload("res://entities/Player.tscn")
const Enemy := preload("res://entities/Enemy.tscn")

var score = 0

func _ready():
	var player = Player.instance()
	player.position = Vector2(320, 435)
	$Player.add_child(player)
	
	_spawn_enemy_row(50, 1)
	_spawn_enemy_row(100, -1)
	_spawn_enemy_row(150, 1)
	_spawn_enemy_row(200, -1)

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
		enemy.connect("enemy_died", self, "_on_Enemy_enemy_died")
		$Enemies.add_child(enemy)

func _on_Enemy_enemy_died():
	score += 50
	$UI/ScoreCount.text = String(score)
