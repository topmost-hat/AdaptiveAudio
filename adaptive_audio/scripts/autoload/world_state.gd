extends Node

enum EnemyType { APPROACHER, SHOOTER, CHARGER }

#region signals
# player
signal game_paused_changed()
signal player_health_changed()

# enemies
signal num_approachers_changed()
signal num_shooters_changed()
signal num_chargers_changed()

# enemies spawning
signal spawning_approacher_changed()
signal spawning_shooter_changed()
signal spawning_charger_changed()
#endregion

#region variables
@export_category("Stats")
@export var _timeElapsed: float = 0.0
@export var _numApproachersKilled: int = 0
@export var _numShootersKilled: int = 0
@export var _numChargersKilled: int = 0

@export_category("Player")
@export var _gamePaused: bool = true
@export var _playerHealth: int = 3

@export_category("Enemies")
@export var _numApproachers: int = 0
@export var _numShooters: int = 0
@export var _numChargers: int = 0

@export_category("Enemies Spawning")
@export var _spawningApproacher: bool = false
@export var _spawningShooter: bool = false
@export var _spawningCharger: bool = false
#endregion

#region Godot functions
func _process(delta: float) -> void:
	if(not _gamePaused): _timeElapsed += delta
#endregion

#region Getters
# stats
func get_time_elapsed() -> float: return _timeElapsed
func get_num_approachers_killed() -> int: return _numApproachersKilled
func get_num_shooters_killed() -> int: return _numShootersKilled
func get_num_chargers_killed() -> int: return _numChargersKilled

func get_num_enemies_killed() -> int:
	return (
		_numApproachersKilled +
		_numShootersKilled +
		_numChargersKilled
	)

# player
func get_game_paused() -> bool: return _gamePaused
func get_player_health() -> int: return _playerHealth

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

# enemies spawning
func get_spawning_approacher() -> bool: return _spawningApproacher
func get_spawning_shooter() -> bool: return _spawningShooter
func get_spawning_charger() -> bool: return _spawningCharger
#endregion

#region Setters
# player
func set_game_paused(setTo: bool):
	_gamePaused = setTo
	game_paused_changed.emit()

# enemies spawning
func set_spawning_approacher(setTo: bool):
	_spawningApproacher = setTo
	spawning_approacher_changed.emit()

func set_spawning_shooter(setTo: bool):
	_spawningShooter = setTo
	spawning_shooter_changed.emit()

func set_spawning_charger(setTo: bool):
	_spawningCharger = setTo
	spawning_charger_changed.emit()
#endregion

#region Adders
# stats
func add_num_approachers_killed(add: int):
	_numApproachersKilled += add

func add_num_shooters_killed(add: int):
	_numShootersKilled += add

func add_num_chargers_killed(add: int):
	_numChargersKilled += add

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
#endregion

#region Resetters
# stats
func reset_time_elapsed() -> void: _timeElapsed = 0.0
func reset_num_approachers_killed() -> void: _numApproachersKilled = 0
func reset_num_shooters_killed() -> void: _numShootersKilled = 0
func reset_num_chargers_killed() -> void: _numChargersKilled = 0

# player
func reset_game_paused() -> void: _gamePaused = false
func reset_player_health() -> void: _playerHealth = 3

# enemies
func reset_num_approachers() -> void: _numApproachers = 0
func reset_num_shooters() -> void: _numShooters = 0
func reset_num_chargers() -> void: _numChargers = 0

# enemies spawning
func reset_spawning_approacher() -> void: _spawningApproacher = false
func reset_spawning_shooter() -> void: _spawningShooter = false
func reset_spawning_charger() -> void: _spawningCharger = false

func reset_all() -> void:
	# stats
	reset_time_elapsed()
	reset_num_approachers_killed()
	reset_num_shooters_killed()
	reset_num_chargers_killed()
	
	# player
	reset_game_paused()
	reset_player_health()
	
	# enemies
	reset_num_approachers()
	reset_num_shooters()
	reset_num_chargers()
	
	# enemies spawning
	reset_spawning_approacher()
	reset_spawning_shooter()
	reset_spawning_charger()
#endregion
