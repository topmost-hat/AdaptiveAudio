class_name BT_Inverter
extends BT_Node

var child: BT_Node

func _ready() -> void:
	child = get_child(0)

func evaluate() -> Status:
	var status = child.evaluate()
	match status:
		Status.FAILURE: return Status.SUCCESS
		Status.SUCCESS: return Status.FAILURE
		Status.RUNNING: return Status.RUNNING
	
	push_warning("BT_Inverter: Child returned invalid status.")
	return Status.NULL
