class_name Approacher
extends Entity

@export var speed: float = 50.0
var target: Node2D

func _ready() -> void:
	WorldState.add_num_approachers(1)

func _exit_tree() -> void:
	WorldState.add_num_approachers(-1)
	WorldState.add_num_approachers_killed(1)

func _physics_process(delta: float) -> void:
	if null == target: return
	position += (target.position - position).normalized() * speed * delta

func hit(other: Node2D):
	if other is Player:
		WorldState.add_player_health(-1)
		queue_free()
