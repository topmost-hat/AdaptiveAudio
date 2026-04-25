class_name MusicLayerEvaluator
extends Node

@export var sync_stream_index: int = -1

var bt_root: BT_Node

func _ready() -> void:
	if 0 >= get_child_count():
		queue_free()
		return
	bt_root = get_child(0)

func evaluate() -> BT_Node.Status: return bt_root.evaluate()
