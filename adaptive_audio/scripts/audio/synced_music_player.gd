class_name SyncedMusicPlayer
extends AudioStreamPlayer

#region Variables
signal music_beat(beat: int)

# gettable
@export var _bpm: float
@export var _fade_time: float = 0.45

var _seconds_per_beat: float
var _length: float
var _playback_time: float = 0.0
var _beat_count: int = 0

# not gettable
var _sync_stream: AudioStreamSynchronized
var _output_latency: float
var _prev_playback_time: float = 0.0
var _beat_timer: float = 0.0
var _fade_check: Array[bool]
#endregion

#region Godot functions
func _ready() -> void:
	# synced music player requires a synced stream
	_sync_stream = stream as AudioStreamSynchronized
	if null == _sync_stream:
		push_error("SyncedMusicPlayer stream is not an AudioStreamSynchronized!")
		queue_free()
	
	# used to increase accuracy of playback time calculation
	_output_latency = AudioServer.get_output_latency()
	
	# length of sync stream == length of longest sub-stream
	_seconds_per_beat = 60.0 / _bpm
	for i: int in _sync_stream.stream_count:
		_length = maxf(_length, _sync_stream.get_sync_stream(i).get_length())
	
	_fade_check.resize(_sync_stream.stream_count)
	_fade_check.fill(false)

func _process(_delta: float) -> void:
	if not playing: return
	
	# calculate playback time with extra precision
	_playback_time = (
		get_playback_position()
		+ AudioServer.get_time_since_last_mix()
		- _output_latency
	)
	var time_step: float = _playback_time - _prev_playback_time
	
	if time_step < 0.0:
		if -0.1 < time_step: return # filter audio thread jitter
		else: time_step += _length # otherwise, correct time step from loop
	
	_prev_playback_time = _playback_time
	_beat_timer += time_step
	
	# if enough time has passed for a beat, count beat and emit beat signal
	if _beat_timer >= _seconds_per_beat:
		_beat_timer -= _seconds_per_beat
		_beat_count += 1
		music_beat.emit(_beat_count)
#endregion

#region Getters
func get_bpm() -> float: return _bpm
func get_seconds_per_beat() -> float: return _seconds_per_beat
func get_length() -> float: return _length
func get_playback_time() -> float: return _playback_time
func get_beat_count() -> int: return _beat_count
func get_stream_volume(index: int) -> float:
	return db_to_linear(_sync_stream.get_sync_stream_volume(index))
#endregion

#region Setters
func set_music_playing(play_music: bool):
	if play_music:
		reset()
		play()
		_beat_count = 1
		music_beat.emit(_beat_count)
	else:
		stop()
		reset()

func set_music_paused(pause_music: bool):
	stream_paused = pause_music

func set_volume(volume: float):
	volume = clampf(volume, 0.0, 1.0)
	volume_linear = volume

func set_stream_volume(volume: float, index: int):
	volume = clampf(volume, 0.0, 1.0)
	_sync_stream.set_sync_stream_volume(index, linear_to_db(volume))
#endregion

#region Other functions
func reset():
	_playback_time = 0.0
	_beat_count = 0
	_prev_playback_time = 0.0
	_beat_timer = 0.0
	
	_output_latency = AudioServer.get_output_latency()

func fade_out_stream(index: int):
	var current_volume: float = db_to_linear(_sync_stream.get_sync_stream_volume(index))
	while current_volume > 0.0:
		if _fade_check[index]: return # fade in has priority
		current_volume -= get_process_delta_time() / _fade_time
		current_volume = clampf(current_volume, 0.0, 1.0)
		_sync_stream.set_sync_stream_volume(index, linear_to_db(current_volume))
		await get_tree().process_frame

func fade_in_stream(index: int):
	_fade_check[index] = true # fade in has priority
	
	var current_volume: float = db_to_linear(_sync_stream.get_sync_stream_volume(index))
	while current_volume < 1.0:
		current_volume += get_process_delta_time() / _fade_time
		current_volume = clampf(current_volume, 0.0, 1.0)
		_sync_stream.set_sync_stream_volume(index, linear_to_db(current_volume))
		await get_tree().process_frame
	
	_fade_check[index] = false # release fade for fade outs
#endregion
