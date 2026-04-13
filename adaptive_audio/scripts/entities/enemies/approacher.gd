extends Entity

@export var speed: float = 100.0
var target: Node2D

func _physics_process(delta: float) -> void:
	if null == target: return
	position += (target.position - position).normalized() * speed * delta

func hit(other: Node2D):
	if other is Player:
		WorldState.add_player_health(-1)
		add_health(-1)
