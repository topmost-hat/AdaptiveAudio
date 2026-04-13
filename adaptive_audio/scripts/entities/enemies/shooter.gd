extends Entity

func _physics_process(delta: float) -> void:
	pass

func hit(other: Node2D):
	if other is Player:
		WorldState.add_player_health(-1)
		add_health(-1)
