extends Node

#region Variables
@export var _player: Player
@export var _player_safe_radius: float = 150.0
@export var _edge_safe_radius: float = 50.0
@export var _difficulty_info: Array[DifficultyInfo]

var _approacher = preload("res://scenes/entity/enemy/approacher.tscn")
var _shooter = preload("res://scenes/entity/enemy/shooter.tscn")
var _charger = preload("res://scenes/entity/enemy/charger.tscn")

var _difficulty: int = 0
var _difficulty_beats: int
var _wave_beats: int
var _spawn_beats: int
var _spawns_left: int
#endregion

#region Godot functions
func _ready() -> void:
	AudioManager.music_beat.connect(_on_music_beat)
	
	_spawns_left = _difficulty_info[_difficulty].enemies_per_wave

func _exit_tree() -> void:
	AudioManager.music_beat.disconnect(_on_music_beat)
#endregion

#region Other functions
func _on_music_beat(_beat: int):
	# difficulty
	_difficulty_beats -= 1
	if 0 >= _difficulty_beats:
		_difficulty = clampi(_difficulty + 1, 0, _difficulty_info.size() - 1)
		_difficulty_beats = _difficulty_info[_difficulty].beats_to_next_difficulty
	
	# enemy spawning
	_wave_beats -= 1
	if 0 <= _wave_beats: return
	
	_spawn_beats -= 1
	if 0 <= _spawn_beats: return
	
	var d_info: DifficultyInfo = _difficulty_info[_difficulty]
	_spawn_next_in_queue()
	_spawn_beats = d_info.beats_between_spawns
	_spawns_left -= 1
	if 1 <= _spawns_left: return
	
	_wave_beats = d_info.beats_between_waves
	_spawn_beats = 0
	_spawns_left = d_info.enemies_per_wave

func _spawn_next_in_queue():
	print("test")

func _select_spawn_pos() -> Vector2:
	var rand_x: float = randf_range(_edge_safe_radius, 1920.0 - _edge_safe_radius)
	var rand_y: float = randf_range(_edge_safe_radius, 1080.0 - _edge_safe_radius)
	var position: Vector2 = Vector2(rand_x, rand_y)
	if (position - _player.position).length() < _player_safe_radius:
		position = _select_spawn_pos() # statistically fine as long as safe radius isn't too huge
	return position
#endregion
