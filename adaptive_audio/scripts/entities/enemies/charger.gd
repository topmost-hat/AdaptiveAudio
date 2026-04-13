class_name Charger
extends Entity

# TODO: charge at the player quickly every fourth beat

@export var speed: float = 100.0
var target: Node2D
var charge_destination: Vector2

func _ready() -> void:
	WorldState.add_num_chargers(1)

func _exit_tree() -> void:
	WorldState.add_num_chargers(-1)
	WorldState.add_num_chargers_killed(1)

func _physics_process(delta: float) -> void:
	pass

func hit(other: Node2D):
	if other is Player:
		WorldState.add_player_health(-1)
		add_health(-1)
