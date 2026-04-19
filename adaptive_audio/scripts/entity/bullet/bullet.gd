@abstract
class_name Bullet
extends Entity

@export var acceleration: float = 1000000.0
@export var max_speed: float = 1000.0
@export var direction: Vector2 :
	set(new_direction): direction = new_direction.normalized()

func _physics_process(delta: float) -> void:
	_move(delta)

func _move(delta: float):
	apply_force(direction * acceleration * delta)
	linear_velocity = linear_velocity.limit_length(max_speed)
