class_name AudioRequirements
extends Node

@export var player: AudioStreamPlayer
@export var sync_stream_index: int = 0

var btRoot: BT_Node
var sync_stream: AudioStreamSynchronized = null

func _ready() -> void:
	if null == player or null == player.stream:
		queue_free()
		return
	
	btRoot = get_child(0)
	if null == btRoot:
		queue_free()
		return
	
	if player.stream is AudioStreamSynchronized:
		sync_stream = player.stream as AudioStreamSynchronized
		if sync_stream_index < 0:
			sync_stream_index = 0
		elif sync_stream_index >= player.stream.stream_count:
			sync_stream_index = player.stream.stream_count - 1
	
	evaluate()

func evaluate():
	var result: BT_Node.Status = btRoot.evaluate()
	if null != sync_stream:
		if BT_Node.Status.SUCCESS == result:
			sync_stream.set_sync_stream_volume(sync_stream_index, 0.0)
		else:
			sync_stream.set_sync_stream_volume(sync_stream_index, -60.0)
	else: player.playing = result
