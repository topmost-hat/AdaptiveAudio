class_name BeatCycleSFXPool
extends AudioStreamPlayer

@export var _num_in_pool: int = 1
var _pool: Array[AudioStreamPlayer]
var _current_index: int = 0

func _ready() -> void:
	if null == stream: queue_free()
	
	AudioManager.music_beat.connect(_on_music_beat)
	for i: int in _num_in_pool:
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		player.stream = stream
		_pool.append(player)
		add_child(player)

func _on_music_beat(_beat: int):
	_current_index += 1
	if _current_index >= _num_in_pool: _current_index = 0

func play_sfx(): _pool[_current_index].play()
