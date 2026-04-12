class_name AudioManager
extends Node

#region Variables
@export var lstn_beat: Array[AudioRequirements]

@export var lstn_difficulty: Array[AudioRequirements]
@export var lstn_player_health: Array[AudioRequirements]
@export var lstn_num_approachers: Array[AudioRequirements]
@export var lstn_num_shooters: Array[AudioRequirements]
@export var lstn_num_chargers: Array[AudioRequirements]
@export var lstn_num_approachers_killed: Array[AudioRequirements]
@export var lstn_num_shooters_killed: Array[AudioRequirements]
@export var lstn_num_chargers_killed: Array[AudioRequirements]
#endregion

#region Godot functions
func _ready() -> void:
	# world
	WorldState.difficulty_changed.connect(rcvd_difficulty)
	
	# player
	WorldState.player_health_changed.connect(rcvd_player_health)
	
	# enemies
	WorldState.num_approachers_changed.connect(rcvd_num_approachers)
	WorldState.num_shooters_changed.connect(rcvd_num_shooters)
	WorldState.num_chargers_changed.connect(rcvd_num_chargers)
	
	# enemies killed
	WorldState.num_approachers_killed_changed.connect(rcvd_num_approachers_killed)
	WorldState.num_shooters_killed_changed.connect(rcvd_num_shooters_killed)
	WorldState.num_chargers_killed_changed.connect(rcvd_num_chargers_killed)
#endregion

#region Signal receivers
# MusicPlayer
func rcvd_beat():
	for listener: AudioRequirements in lstn_beat:
		listener.evaluate()

# world
func rcvd_difficulty():
	for listener: AudioRequirements in lstn_difficulty:
		listener.evaluate()

# player
func rcvd_player_health():
	for listener: AudioRequirements in lstn_player_health:
		listener.evaluate()

# enemies
func rcvd_num_approachers():
	for listener: AudioRequirements in lstn_num_approachers:
		listener.evaluate()

func rcvd_num_shooters():
	for listener: AudioRequirements in lstn_num_shooters:
		listener.evaluate()

func rcvd_num_chargers():
	for listener: AudioRequirements in lstn_num_chargers:
		listener.evaluate()

# enemies killed
func rcvd_num_approachers_killed():
	for listener: AudioRequirements in lstn_num_approachers_killed:
		listener.evaluate()

func rcvd_num_shooters_killed():
	for listener: AudioRequirements in lstn_num_shooters_killed:
		listener.evaluate()

func rcvd_num_chargers_killed():
	for listener: AudioRequirements in lstn_num_chargers_killed:
		listener.evaluate()
#endregion
