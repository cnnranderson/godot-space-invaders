extends Area2D

export var cur_speed = 50.0
export var drop_distance = 50.0

var left_bound = 40
var right_bound = 600
var dir = 1

signal enemy_died

func _process(delta):
	var movement = Vector2.ZERO
	
	if (position.x <= left_bound or position.x >= right_bound):
		movement.y += drop_distance
		dir = dir * -1
	
	movement.x += cur_speed * dir * delta
	
	position += movement
	position.x = clamp(position.x, left_bound, right_bound)

func kill():
	emit_signal("enemy_died")
	queue_free()

func _on_Enemy_body_entered(body):
	if body is Bullet:
		kill()
		body.hit()
	
	if body is Player:
		get_tree().reload_current_scene()
