extends KinematicBody2D
class_name Bullet

export var speed = 250.0
export var dir = 1
export var source = "none"

func _process(delta):
	var move = Vector2.ZERO
	position.y += speed * dir * delta
	position += move

func hit():
	queue_free()

# Destroy the bullet if we left the scene
func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
