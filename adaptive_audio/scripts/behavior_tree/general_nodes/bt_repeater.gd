class_name BT_Repeater
extends BT_Node

@export var iterations: int
var child: BT_Node

func _ready() -> void:
	child = get_child(0)

func evaluate() -> Status:
	for i: int in iterations:
		var status = child.evaluate()
		if status != Status.SUCCESS: return status
	return Status.SUCCESS
