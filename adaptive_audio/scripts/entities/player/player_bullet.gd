class_name PlayerBullet
extends Entity

@export var direction: Vector2
@export var speed: float = 1000.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func hit(other: Node2D):
	add_health(-1)
	if other is Entity:
		(other as Entity).add_health(-1)
