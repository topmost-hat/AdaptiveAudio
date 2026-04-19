class_name PlayerBullet
extends Bullet

func _entity_collision(other: Entity):
	if other is Enemy:
		add_health(-1)

func _player_collision(_player: Player): pass

func _other_collision(_body: Node):
	die()
