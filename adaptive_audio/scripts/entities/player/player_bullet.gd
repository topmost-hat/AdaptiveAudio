class_name PlayerBullet
extends Entity

@export var direction: Vector2
@export var speed: float = 250.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func hit(other: Node2D):
	if other is Entity:
		if other is PlayerBullet: return
		add_health(-1)
		(other as Entity).add_health(-1)
