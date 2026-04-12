class_name BT_IsTrue
extends BT_Node

@export var worldStateGetterName: String

func evaluate() -> Status:
	var value = Callable(WorldState, worldStateGetterName).call()
	if value: return Status.SUCCESS
	return Status.FAILURE
