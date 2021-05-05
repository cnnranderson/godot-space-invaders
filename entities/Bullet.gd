extends KinematicBody2D
class_name Bullet

export var speed = 250.0
export var dir = 1

func _process(delta):
	var move = Vector2.ZERO
	position.y += speed * dir * delta
	position += move

func hit():
	queue_free()

# Destroy the bullet if we left the scene
func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
