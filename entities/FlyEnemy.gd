extends Enemy

func _ready():
	pass

func _customer_movement():
	pass

func _on_FlyEnemy_area_entered(area):
	._on_Enemy_area_entered(area)

func _on_FlyEnemy_body_entered(body):
	._on_Enemy_body_entered(body)
