class_name MusicLayerEvaluator
extends Node

@export var sync_stream_index: int = -1

var bt_root: BT_Node

func _ready() -> void:
	bt_root = get_child(0)
	assert(null != bt_root, name + " couldn't find the root of its BT!")

func evaluate() -> BT_Node.Status: return bt_root.evaluate()
