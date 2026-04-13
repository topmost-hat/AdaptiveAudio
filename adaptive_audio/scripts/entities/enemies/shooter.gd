class_name Shooter
extends Entity

# TODO: shoot a burst every other beat

var enemy_bullet = preload("res://scenes/entities/enemies/enemy_bullet.tscn")
var target: Node2D

func _ready() -> void:
	WorldState.add_num_shooters(1)

func _exit_tree() -> void:
	WorldState.add_num_shooters(-1)
	WorldState.add_num_shooters_killed(1)

func _process(delta: float) -> void:
	pass

func hit(other: Node2D):
	if other is Player:
		WorldState.add_player_health(-1)
		queue_free()
