extends Area2D
class_name Enemy

const iBullet = preload("res://entities/Bullet.tscn")
const iFloatingText = preload("res://ui/FloatingText.tscn")
const ExplosionSound = "res://sounds/explosion.wav"
const LaserSound = "res://sounds/laser.wav"

export var cur_speed = 50.0
export var death_value = 50
export var unique_path = false

var enemy_type = Global.EnemyType.ALIEN

func _ready():
	$AnimatedSprite.play()

func _process(delta):
	# Short circuit movement code for now for new movement
	if not unique_path:
		return
	else:
		_custom_movement(delta)

func _custom_movement(delta):
	pass

func kill(gives_points):
	SoundManager.play_sound_2d(SoundManager.SoundType.SFX, ExplosionSound, position)
	EventManager.emit_signal("enemy_died", enemy_type, death_value if gives_points else 0)
	if gives_points:
		var points = iFloatingText.instance()
		points.amount = death_value
		points.position = position
		$"../../OverlayText".add_child(points)
	queue_free()

func shoot():
	var bullet = iBullet.instance()
	bullet.source = "enemy"
	bullet.position = Vector2(position.x, position.y)
	bullet.dir = 1
	
	# Still not sure how I feel about this - if I change the parent/location of 
	# the Player node, I could end up with annoying side effects.
	$"../../Effects".add_child(bullet)
	SoundManager.play_sound_2d(SoundManager.SoundType.SFX, LaserSound, position)

func _on_Enemy_body_entered(body):
	if body is Bullet and body.source != "enemy":
		kill(true)
		body.hit()


func _on_Enemy_area_entered(area):
	if area.is_in_group("player"):
		kill(false)
