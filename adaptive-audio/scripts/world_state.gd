extends Node

enum EnemyType { APPROACHER, SHOOTER, CHARGER }

#region signals
signal game_paused_changed()
signal difficulty_changed()

signal player_health_changed()
signal time_last_hit_changed()

signal num_approachers_changed()
signal num_shooters_changed()
signal num_chargers_changed()

signal num_approachers_killed_changed()
signal num_shooters_killed_changed()
signal num_chargers_killed_changed()
#endregion

#region variables
@export_category("World")
@export var _timeElapsed: float = 0.0
@export var _gamePaused: bool = true
@export var _difficulty: int = 1

@export_category("Player")
@export var _playerHealth: int = 3
@export var _timeLastHit: float = 0.0

@export_category("Enemies")
@export var _numApproachers: int = 0
@export var _numShooters: int = 0
@export var _numChargers: int = 0

@export_category("Enemies Killed")
@export var _numApproachersKilled: int = 0
@export var _numShootersKilled: int = 0
@export var _numChargersKilled: int = 0
#endregion

#region Godot functions
func _ready() -> void:
	# world
	reset_time_elapsed()
	reset_difficulty()
	
	# player
	reset_player_health()
	reset_time_last_hit()
	
	# enemies
	reset_num_approachers()
	reset_num_shooters()
	reset_num_chargers()
	
	# enemies killed
	reset_num_approachers_killed()
	reset_num_shooters_killed()
	reset_num_chargers_killed()
	
func _process(delta: float) -> void:
	if(not _gamePaused): _timeElapsed += delta
#endregion

#region Getters
# world
func get_time_elapsed() -> float: return _timeElapsed
func get_game_paused() -> bool: return _gamePaused
func get_difficulty() -> int: return _difficulty

# player
func get_player_health() -> int: return _playerHealth
func get_time_last_hit() -> float: return _timeLastHit

# enemies
func get_num_approachers() -> int: return _numApproachers
func get_num_shooters() -> int: return _numShooters
func get_num_chargers() -> int: return _numChargers

func get_num_enemies() -> int:
	return (
		_numApproachers +
		_numShooters +
		_numChargers
	)

# enemies killed
func get_num_approachers_killed() -> int: return _numApproachersKilled
func get_num_shooters_killed() -> int: return _numShootersKilled
func get_num_chargers_killed() -> int: return _numChargersKilled

func get_num_enemies_killed() -> int:
	return (
		_numApproachersKilled +
		_numShootersKilled +
		_numChargersKilled
	)
#endregion

#region Setters
# world
func set_game_paused(setTo: bool):
	_gamePaused = setTo
	game_paused_changed.emit()

# player
func set_time_last_hit(setTo: float):
	_timeLastHit = setTo
	time_last_hit_changed.emit()
#endregion

#region Adders
# world
func add_difficulty(add: int):
	_difficulty += add
	difficulty_changed.emit()

# player
func add_player_health(add: int):
	_playerHealth += add
	player_health_changed.emit()

# enemies
func add_num_approachers(add: int):
	_numApproachers += add
	num_approachers_changed.emit()

func add_num_shooters(add: int):
	_numShooters += add
	num_shooters_changed.emit()

func add_num_chargers(add: int):
	_numChargers += add
	num_chargers_changed.emit()

# enemies killed
func add_num_approachers_killed(add: int):
	_numApproachersKilled += add
	num_approachers_killed_changed.emit()

func add_num_shooters_killed(add: int):
	_numShootersKilled += add
	num_shooters_killed_changed.emit()

func add_num_chargers_killed(add: int):
	_numChargersKilled += add
	num_chargers_killed_changed.emit()
#endregion

#region Resetters
# world
func reset_time_elapsed() -> void: _timeElapsed = 0.0
func reset_difficulty() -> void: _difficulty = 1

# player
func reset_player_health() -> void: _playerHealth = 3
func reset_time_last_hit() -> void: _timeLastHit = 0.0

# enemies
func reset_num_approachers() -> void: _numApproachers = 0
func reset_num_shooters() -> void: _numShooters = 0
func reset_num_chargers() -> void: _numChargers = 0

# enemies killed
func reset_num_approachers_killed() -> void: _numApproachersKilled = 0
func reset_num_shooters_killed() -> void: _numShootersKilled = 0
func reset_num_chargers_killed() -> void: _numChargersKilled = 0
#endregion
