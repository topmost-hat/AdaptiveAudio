class_name BT_WithinRangeInt
extends BT_Node

@export var fact_name: String
@export var min_value: int
@export var max_value: int

func evaluate() -> Status:
	var value: int = WorldState.get_fact(fact_name)
	if null == value:
		push_error("Invalid fact name in BT WorldState node!")
		return Status.FAILURE
	
	if min_value <= value and value <= max_value: return Status.SUCCESS
	else: return Status.FAILURE
