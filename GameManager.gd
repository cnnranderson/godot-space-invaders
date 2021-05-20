extends Node

const Enemy := preload("res://entities/Enemy.tscn")

var enemy_grid = []
var wave_width = 8
var wave_height = 4
var wave_dir = 1
var wave_speed = 20
var limit_right = 600
var limit_left = 40
var delay_move = false
var delay_timer = .1
var delay_move_countdown = delay_timer
var all_rows_moved = true
var last_row_moved = -1

func _ready():
	for y in range(4):
		enemy_grid.append([])
		for x in range(8):
			var enemy = Enemy.instance()
			enemy.position = Vector2(150 + (50 * x), 180 - (40 * y))
			enemy.dir = wave_dir
			enemy.connect("enemy_died", $GameGUI, "_on_Enemy_enemy_died")
			enemy.connect("enemy_died", self, "_on_GameManager_enemy_died")
			enemy_grid[y].append(enemy)
			$Enemies.add_child(enemy)
			
	#_spawn_enemy_row(50, 1)
	#_spawn_enemy_row(100, -1)
	#_spawn_enemy_row(150, 1)
	#_spawn_enemy_row(250, -1)

func _process(delta):
	if Input.is_action_pressed("debug_quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("debug_restart"):
		return get_tree().reload_current_scene()
		
	for y in range(wave_height):
		if not delay_move and last_row_moved < y:
			var max_left = limit_right
			var max_right = limit_left
			var should_drop = false
			for x in range(wave_width):
				var e = enemy_grid[y][x]
				if is_instance_valid(e):
					if e.position.x < max_left and wave_dir < 0:
						max_left = e.position.x
					if e.position.x > max_right and wave_dir > 0:
						max_right = e.position.x
			
			should_drop = max_left < limit_left or max_right > limit_right
			if should_drop:
				delay_move = true
				last_row_moved += 1
				for x in range(wave_width):
					var e = enemy_grid[y][x]
					if is_instance_valid(e):
						e.position.y += 40
			else:
				for x in range(wave_width):
					var e = enemy_grid[y][x]
					if is_instance_valid(e):
						e.position.x += wave_speed * delta * wave_dir
						
	delay_move_countdown -= delta
	if delay_move_countdown <= 0:
		delay_move_countdown = delay_timer
		delay_move = false
	
	if last_row_moved >= wave_height - 1:
		last_row_moved = -1
		all_rows_moved = true
		wave_dir = -wave_dir

func _spawn_enemy_row(y, dir):
	for n in range(8):
		var enemy = Enemy.instance()
		enemy.position = Vector2(150 + (50 * n), y)
		enemy.dir = dir
		enemy.connect("enemy_died", $GameGUI, "_on_Enemy_enemy_died")
		enemy.connect("enemy_died", self, "_on_Enemy_enemy_died")
		$Enemies.add_child(enemy)
		
func _on_GameManager_enemy_died(value):
	wave_speed += 2
