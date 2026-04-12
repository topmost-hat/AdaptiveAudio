class_name BT_WithinRange
extends BT_Node

@export var worldStateGetterName: String
@export var minValue: float = -1.0
@export var maxValue: float = 1.0

func _ready() -> void:
	if minValue > maxValue:
		var temp = minValue
		minValue = maxValue
		maxValue = temp

func evaluate() -> Status:
	var value = Callable(WorldState, worldStateGetterName).call()
	if value >= minValue and value <= maxValue: return Status.SUCCESS
	return Status.FAILURE
