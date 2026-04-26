class_name EnemyManager
extends Node

#region Variables
@export var player: Player
@export var _player_safe_radius: float = 400.0
@export var _edge_safe_radius: float = 50.0
@export var _difficulty_info: Array[DifficultyInfo]

var _approacher = preload("res://scenes/entity/enemy/approacher.tscn")
var _shooter = preload("res://scenes/entity/enemy/shooter.tscn")
var _charger = preload("res://scenes/entity/enemy/charger.tscn")

var _difficulty: int
var _difficulty_beats: int

var _wave_beats: int
var _spawn_beats: int
var _spawns_left: int
var _spawn_queue_index: int
#endregion

#region Godot functions
func _ready() -> void:
	AudioManager.music_beat.connect(_on_music_beat)
	WorldState.connect_to_fact("PlayerHealth", _on_player_health_changed)
	
	for d_info in _difficulty_info: d_info.count_enemies()
	reset()

func _exit_tree() -> void:
	AudioManager.music_beat.disconnect(_on_music_beat)
#endregion

#region Signal receiver functions
func _on_music_beat(_beat: int):
	if null == player:
		push_error("Player not assigned in EnemyManager.")
		return
	
	# difficulty
	_difficulty_beats -= 1
	if 0 >= _difficulty_beats:
		_difficulty = clampi(_difficulty + 1, 0, _difficulty_info.size() - 1)
		_difficulty_beats = _difficulty_info[_difficulty].beats_to_next_difficulty
		_wave_beats = 0
		_spawn_beats = 0
		_spawns_left = _difficulty_info[_difficulty].enemies_per_wave
		_spawn_queue_index = 0
		WorldState.set_fact("Difficulty", _difficulty)
	
	# enemy spawning
	_wave_beats -= 1
	if 0 <= _wave_beats: return
	
	_spawn_beats -= 1
	if 0 <= _spawn_beats: return
	
	var d_info: DifficultyInfo = _difficulty_info[_difficulty]
	_spawn_next_in_queue()
	_spawn_beats = d_info.beats_between_spawns
	_spawns_left -= 1
	if 0 < _spawns_left: return
	
	_wave_beats = d_info.beats_between_waves
	_spawn_beats = 0
	_spawns_left = d_info.enemies_per_wave

func _on_player_health_changed():
	if 0 >= WorldState.get_fact("PlayerHealth"):
		despawn_all()
#endregion

#region Spawning functions
func _spawn_next_in_queue() -> bool:
	var was_enemy_spawned: bool = false
	var d_info = _difficulty_info[_difficulty]
	
	# get number of each enemy from WorldState
	var num_approachers: int = WorldState.get_fact("NumApproachers")
	var num_shooters: int = WorldState.get_fact("NumShooters")
	var num_chargers: int = WorldState.get_fact("NumChargers")
	
	# cycle thru queue until either an enemy to spawn
	# is found or the entire queue is iterated thru
	for i in d_info.spawn_queue.size():
		match d_info.spawn_queue[_spawn_queue_index]:
			Enemy.Type.APPROACHER:
				if num_approachers < d_info.max_enemies_of_type(Enemy.Type.APPROACHER):
					_spawn_approacher(_select_spawn_pos())
					was_enemy_spawned = true
			Enemy.Type.SHOOTER:
				if num_shooters < d_info.max_enemies_of_type(Enemy.Type.SHOOTER):
					_spawn_shooter(_select_spawn_pos())
					was_enemy_spawned = true
			Enemy.Type.CHARGER:
				if num_chargers < d_info.max_enemies_of_type(Enemy.Type.CHARGER):
					_spawn_charger(_select_spawn_pos())
					was_enemy_spawned = true
		_spawn_queue_index = (_spawn_queue_index + 1) % d_info.spawn_queue.size()
		if was_enemy_spawned: break
	
	return was_enemy_spawned

func _spawn_approacher(position: Vector2):
	var instance: Approacher = _approacher.instantiate() as Approacher
	instance.position = position
	instance.target = player
	add_child(instance)
	AudioManager.play_sfx("BellSynthHigh", true)

func _spawn_shooter(position: Vector2):
	var instance: Shooter = _shooter.instantiate() as Shooter
	instance.position = position
	instance.target = player
	add_child(instance)
	AudioManager.play_sfx("BellSynthMid", true)

func _spawn_charger(position: Vector2):
	var instance: Charger = _charger.instantiate() as Charger
	instance.position = position
	instance.target = player
	add_child(instance)
	AudioManager.play_sfx("BellSynthLow", true)

func _select_spawn_pos() -> Vector2:
	var rand_x: float = randf_range(_edge_safe_radius, 1920.0 - _edge_safe_radius)
	var rand_y: float = randf_range(_edge_safe_radius, 1080.0 - _edge_safe_radius)
	var position: Vector2 = Vector2(rand_x, rand_y)
	if (position - player.position).length() < _player_safe_radius:
		position = _select_spawn_pos() # statistically fine as long as safe radius isn't too huge
	return position

func despawn_all():
	for child in get_children():
		child.queue_free()
#endregion

#region Other functions
func reset():
	_difficulty = 0
	_difficulty_beats = _difficulty_info[_difficulty].beats_to_next_difficulty
	_wave_beats = 0
	_spawn_beats = 0
	_spawns_left = _difficulty_info[_difficulty].enemies_per_wave
	_spawn_queue_index = 0
#endregion
