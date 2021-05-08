extends Area2D
class_name Enemy

export var cur_speed = 50.0
export var drop_distance = 50.0
export var death_value = 50

var left_bound = 40
var right_bound = 600
var dir = 1

# Signals
signal enemy_died

func _process(delta):
	var movement = Vector2.ZERO
	
	if (position.x <= left_bound or position.x >= right_bound):
		movement.y += drop_distance
		dir = dir * -1
	
	movement.x += cur_speed * dir * delta
	
	position += movement
	position.x = clamp(position.x, left_bound, right_bound)

func kill(gives_points):
	emit_signal("enemy_died", death_value if gives_points else 0)
	queue_free()

func _on_Enemy_body_entered(body):
	if body is Bullet:
		kill(true)
		body.hit()
	
	if body is Player:
		body.player_died()
		kill(false)
