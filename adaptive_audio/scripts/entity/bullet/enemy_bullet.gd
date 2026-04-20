class_name EnemyBullet
extends Bullet

func _entity_collision(_other: Entity): print("test")

func _player_collision(player: Player):
	add_health(-1)
	player.player_health.add_health(-1)

func _other_collision(_body: Node):
	die()
