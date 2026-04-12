class_name BT_Selector
extends BT_Node

var children: Array[BT_Node]

func _ready() -> void:
	children.assign(find_children("*", "BT_Node"))

func evaluate() -> Status:
	for child: BT_Node in children:
		var status = child.evaluate()
		if status != Status.FAILURE: return status
	return Status.FAILURE
