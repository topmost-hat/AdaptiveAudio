class_name EnemyBullet
extends Bullet

func _entity_collision(_other: Entity): print("test")

func _player_collision(_player: Player):
	WorldState.add_fact("PlayerHealth", -1)
	add_health(-1)

func _other_collision(_body: Node):
	die()
