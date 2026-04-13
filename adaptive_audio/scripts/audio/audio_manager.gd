class_name AudioManager
extends Node

@export var lstn_player_health: Array[AudioRequirements]
@export var lstn_num_approachers: Array[AudioRequirements]
@export var lstn_num_shooters: Array[AudioRequirements]
@export var lstn_num_chargers: Array[AudioRequirements]

@export var bell_synth_high: AudioStreamPlayer
@export var bell_synth_mid: AudioStreamPlayer
@export var bell_synth_low: AudioStreamPlayer

func _ready() -> void:
	WorldState.player_health_changed.connect(rcvd_player_health)
	WorldState.num_approachers_changed.connect(rcvd_num_approachers)
	WorldState.num_shooters_changed.connect(rcvd_num_shooters)
	WorldState.num_chargers_changed.connect(rcvd_num_chargers)
	
	WorldState.spawning_approacher_changed.connect(play_bell_high)
	WorldState.spawning_shooter_changed.connect(play_bell_mid)
	WorldState.spawning_charger_changed.connect(play_bell_low)

func rcvd_player_health():
	for listener: AudioRequirements in lstn_player_health:
		listener.evaluate()

func rcvd_num_approachers():
	for listener: AudioRequirements in lstn_num_approachers:
		listener.evaluate()

func rcvd_num_shooters():
	for listener: AudioRequirements in lstn_num_shooters:
		listener.evaluate()

func rcvd_num_chargers():
	for listener: AudioRequirements in lstn_num_chargers:
		listener.evaluate()

func play_bell_high(): bell_synth_high.play()
func play_bell_mid(): bell_synth_mid.play()
func play_bell_low(): bell_synth_low.play()
