extends Node

const Enemy = preload("res://entities/Enemy.tscn")
const Ufo = preload("res://entities/Ufo.tscn")

# TODO: This all feels really messy and I should probably clean this up with a
#       level manager or something more event driven (for future features).
var enemy_grid = []
var wave_width = 8
var wave_height = 1
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
var ufo_enabled = true
var score = 0

func _ready():
	$Enemies/UfoTimer.wait_time = randi() % 16 + 20
	$YouWin.visible = false
	EventManager.connect("enemy_died", self, "_on_Event_enemy_died")
	EventManager.connect("game_won", self, "_on_Event_game_won")
	_spawn_enemies()

func _process(delta):
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

func _spawn_enemies():
	# Setup enemies
	for y in range(wave_height):
		enemy_grid.append([])
		for x in range(wave_width):
			var enemy = Enemy.instance()
			enemy.position = Vector2(150 + (50 * x), 180 - (40 * y))
			enemy_grid[y].append(enemy)
			enemy_count += 1
			$Enemies.add_child(enemy)

func _spawn_ufo():
	var ufo = Ufo.instance()
	ufo.position = Vector2(-20, 30)
	$Enemies.add_child(ufo)

func _check_highscore():
	var scores = GlobalManager.high_scores.duplicate()
	scores.append(score)
	scores.sort()
	scores.invert()
	for i in range(0, GlobalManager.high_scores.size()):
		GlobalManager.high_scores[i] = scores[i]
	SaveManager.save()

func _on_Event_enemy_died(enemy_type, value):
	# Add any possible points
	score += value
	
	# UFOs shouldn't influence game pace -- just a bonus
	if enemy_type == GlobalManager.EnemyType.UFO:
		return
	
	# Modify game difficulty and progress of level
	wave_speed += 2
	enemy_count -= 1
	if enemy_count == 1:
		wave_speed = 300
	elif enemy_count <= 0:
		EventManager.emit_signal("game_won")

func _on_Event_game_won():
	$YouWin.visible = true
	ufo_enabled = false
	_check_highscore()

func _on_FireTimer_timeout():
	# Only try to shoot if we have enemies
	if enemy_count == 0:
		return
	
	var bottom_enemies = []
	var column_used = []
	for y in range(wave_height):
		for x in range(wave_width):
			if not column_used.has(x):
				var e = enemy_grid[y][x]
				if is_instance_valid(e):
					bottom_enemies.append(e)
					column_used.append(x)
	
	if bottom_enemies.size() > 0:
		var shooting_enemy = bottom_enemies[randi() % bottom_enemies.size()]
		shooting_enemy.shoot()
	$Enemies/FireTimer.start()

func _on_UfoTimer_timeout():
	if ufo_enabled:
		_spawn_ufo()
		$Enemies/UfoTimer.wait_time = randi() % 16 + 20
	else:
		$Enemies/UfoTimer.wait_time = 3
	$Enemies/UfoTimer.start()
