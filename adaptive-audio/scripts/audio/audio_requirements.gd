class_name AudioRequirements
extends Node

@export var player: AudioStreamPlayer
@export var sync_stream_index: int = 0

var btRoot: BT_Node

func _ready() -> void:
	if null == player or null == player.stream:
		queue_free()
		return
	
	btRoot = get_child(0)
	if null == btRoot:
		queue_free()
		return
	
	if player.stream is AudioStreamSynchronized:
		if sync_stream_index < 0:
			sync_stream_index = 0
		elif sync_stream_index >= player.stream.stream_count:
			sync_stream_index = player.stream.stream_count - 1

func evaluate():
	var result: BT_Node.Status = btRoot.evaluate()
	if player.stream is AudioStreamSynchronized:
		if BT_Node.Status.SUCCESS == result:
			player.stream.set_sync_stream_volume(sync_stream_index, 0.0)
		else:
			player.stream.set_sync_stream_volume(sync_stream_index, -60.0)
	else: player.playing = result
