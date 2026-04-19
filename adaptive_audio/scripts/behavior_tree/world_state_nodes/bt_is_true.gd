class_name BT_IsTrue
extends BT_Node

@export var fact_name: String

func evaluate() -> Status:
	var value: bool = WorldState.get_fact(fact_name)
	if null == value:
		push_error("Invalid fact name in BT WorldState node!")
		return Status.FAILURE
	
	if value: return Status.SUCCESS
	else: return Status.FAILURE
