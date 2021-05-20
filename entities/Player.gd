extends KinematicBody2D
class_name Player

const iBullet = preload("res://entities/Bullet.tscn")
const LaserSound = "res://sounds/laser.wav"
const PlayerExplosionSound = "res://sounds/player_explosion.wav"

export var speed = 250.0
export var bullet_wait_time = 200.0
export var bullet_reload_speed = 200.0
export var lives = 3

var bullet_time = 0

# Signals
signal player_died(lives)

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

func player_hit():
	lives -= 1
	$"/root/SoundManager".play_sound_2d(PlayerExplosionSound, position)
	emit_signal("player_died", lives)
	
	if lives <= 0:
		var _switch = get_tree().reload_current_scene()

# Fire a bullet
func _fire():
	bullet_time = bullet_wait_time
	var bullet = iBullet.instance()
	bullet.source = "player"
	bullet.position = Vector2(position.x, position.y)
	bullet.dir = -1
	
	# get_tree().root.get_node("Main").call_deferred("add_child", bullet)
	# Still not sure how I feel about this - if I change the parent/location of 
	# the Player node, I could end up with annoying side effects.
	$"../../Effects".add_child(bullet)
	$"/root/SoundManager".play_sound_2d(LaserSound, position)

func _on_Player_body_entered(body):
	if body is Bullet && body.source != "player":
		player_hit()

