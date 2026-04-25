class_name BT_BeatWithinRange
extends BT_Node

@export var cycle: int = 4
@export var min_value: int
@export var max_value: int

func evaluate() -> Status:
	var value: int = (AudioManager.get_beat_count() - 1) % cycle
	if min_value - 1 <= value and value <= max_value - 1: return Status.SUCCESS
	else: return Status.FAILURE
