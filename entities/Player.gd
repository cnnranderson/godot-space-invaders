extends Area2D
class_name Player

var Bullet = preload("res://entities/Bullet.tscn")

export var speed = 250.0
export var bullet_wait_time = 200.0
export var bullet_reload_speed = 200.0

var bullet_time = 0

func _process(delta):
	_handle_input(delta)

# Handle input/controls
func _handle_input(delta):
	# Movement inputs
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x -= 1.0
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1.0
	
	position += direction * speed * delta
	position.x = clamp(position.x, 20, 620)
	
	# Shooting inputs
	bullet_time -= bullet_reload_speed * delta
	bullet_time = clamp(bullet_time, 0, bullet_wait_time)
	if Input.is_action_pressed("shoot") and bullet_time == 0:
		_fire()

# Fire a bullet
func _fire():
	bullet_time = bullet_wait_time
	var bullet = Bullet.instance()
	bullet.position = Vector2(position.x, position.y)
	bullet.dir = -1
	get_tree().root.get_node("Main").call_deferred("add_child", bullet)
