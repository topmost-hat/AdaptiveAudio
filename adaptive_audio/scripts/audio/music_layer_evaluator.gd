class_name MusicLayerEvaluator
extends Node

@export var sync_stream_index: int

var bt_root: BT_Node

func _ready() -> void:
	bt_root = get_child(0)
	if null == bt_root:
		queue_free()
		return

func evaluate() -> BT_Node.Status: return bt_root.evaluate()
