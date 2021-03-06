extends Area2D
class_name Player

const _Bullet = preload("res://entities/Bullet.tscn")
const LaserSound = "res://sounds/laser.wav"
const PlayerExplosionSound = "res://sounds/player_explosion.wav"

export var speed = 200.0
export var bullet_wait_time = 200.0
export var bullet_reload_speed = 200.0
export var lives = 3

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

func player_hit():
	lives -= 1
	SoundManager.play_sound_2d(SoundManager.SoundType.SFX, PlayerExplosionSound, position)
	EventManager.emit_signal("player_hurt", lives)
	
	if lives <= 0:
		EventManager.emit_signal("player_lost")

# Fire a bullet
func _fire():
	print("Overwrite?")
	bullet_time = bullet_wait_time
	var bullet = _Bullet.instance()
	bullet.source = "player"
	bullet.position = Vector2(position.x, position.y)
	bullet.dir = -1
	
	# get_tree().root.get_node("Main").call_deferred("add_child", bullet)
	# Still not sure how I feel about this - if I change the parent/location of 
	# the Player node, I could end up with annoying side effects.
	$"../Effects".add_child(bullet)
	SoundManager.play_sound_2d(SoundManager.SoundType.SFX, LaserSound, position)

func _on_Player_body_entered(body):
	if body is Bullet and body.source != "player":
		player_hit()
		body.hit()

func _on_Player_area_entered(area):
	if area.is_in_group("enemy"):
		player_hit()
