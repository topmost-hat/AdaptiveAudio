class_name EnemyBullet
extends Entity

@export var direction: Vector2
@export var speed: float = 250.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func hit(other: Node2D):
	if other is not Entity:
		add_health(-1)
		if other is Player: WorldState.add_player_health(-1)
