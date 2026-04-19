@abstract
class_name Entity
extends RigidBody2D

@export var health: int = 1

@abstract func _entity_collision(other: Entity)
@abstract func _player_collision(player: Player)
@abstract func _other_collision(body: Node)

func _on_body_entered(body: Node):
	if body is Entity: _entity_collision(body as Entity)
	elif body is Player: _player_collision(body as Player)
	else: _other_collision(body)

func add_health(add: int):
	health += add
	if 0 >= health: die()

func die():
	queue_free()
