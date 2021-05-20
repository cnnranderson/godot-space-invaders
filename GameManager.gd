extends Node

const Enemy := preload("res://entities/Enemy.tscn")

signal game_won

var enemy_grid = []
var wave_width = 8
var wave_height = 4
var wave_dir = 1
var wave_speed = 10
var limit_right = 610
var limit_left = 30
var delay_move = false
var delay_timer = .1
var delay_move_countdown = delay_timer
var all_rows_moved = true
var last_row_moved = -1
var enemy_count = 0
var is_dropping = false

func _ready():
	$YouWin.visible = false
	_add_enemies()

func _process(delta):
	if Input.is_action_pressed("debug_quit"):
		get_tree().quit()
	
	if Input.is_action_pressed("debug_restart"):
		return get_tree().reload_current_scene()
	
	# Process enemy movement
	if delay_move and is_dropping:
		delay_move_countdown -= delta
		if delay_move_countdown <= 0:
			delay_move_countdown = delay_timer
			delay_move = false
	elif is_dropping:
		var dropped = false
		for x in range(wave_width):
			var e = enemy_grid[last_row_moved][x]
			if is_instance_valid(e):
				dropped = true
				e.position.y += 20
		last_row_moved += 1
		if last_row_moved >= wave_height:
			is_dropping = false
			wave_dir = -wave_dir
		else:
			delay_move = dropped
	else:
		for y in range(wave_height):
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
				is_dropping = true
				last_row_moved = 0
			else:
				for x in range(wave_width):
					var e = enemy_grid[y][x]
					if is_instance_valid(e):
						e.position.x += wave_speed * delta * wave_dir

func _add_enemies():
	# Setup enemies
	for y in range(wave_height):
		enemy_grid.append([])
		for x in range(wave_width):
			var enemy = Enemy.instance()
			enemy.position = Vector2(150 + (50 * x), 180 - (40 * y))
			enemy.dir = wave_dir
			enemy.connect("enemy_died", $GameGUI, "_on_Enemy_enemy_died")
			enemy.connect("enemy_died", self, "_on_GameManager_enemy_died")
			enemy_grid[y].append(enemy)
			$Enemies.add_child(enemy)
			enemy_count += 1

func _on_GameManager_enemy_died(value):
	wave_speed += 2
	enemy_count -= 1
	if enemy_count == 1:
		wave_speed = 300
	elif enemy_count <= 0:
		emit_signal("game_won")

func _on_Main_game_won():
	$YouWin.visible = true
