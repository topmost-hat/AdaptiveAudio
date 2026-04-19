extends Node

#region Variables
signal music_beat(beat: int)

# which evaluators should listen to which WorldState changes
@export var lstn_player_health: Array[MusicLayerEvaluator]
@export var lstn_num_approachers: Array[MusicLayerEvaluator]
@export var lstn_num_shooters: Array[MusicLayerEvaluator]
@export var lstn_num_chargers: Array[MusicLayerEvaluator]
# TODO: more listener arrays for more WorldState changes

var sfx_dict: Dictionary[String, AudioStreamPlayer]

@onready var synced_music_player: SyncedMusicPlayer = $SyncedMusicPlayer
@onready var music_layer_evaluators: Node = $MusicLayerEvaluators
@onready var sfx_players: Node = $SFXPlayers
#endregion

#region Godot functions
func _ready() -> void:
	for player in sfx_players.get_children():
		if player is AudioStreamPlayer:
			sfx_dict[player.name] = player as AudioStreamPlayer
	
	WorldState.connect_to_fact("PlayerHealth", _on_player_health_changed)
	WorldState.connect_to_fact("NumApproachers", _on_num_approachers_changed)
	WorldState.connect_to_fact("NumShooters", _on_num_shooters_changed)
	WorldState.connect_to_fact("NumChargers", _on_num_chargers_changed)
#endregion

#region Signal receiver functions
func _on_music_beat(beat: int) -> void: music_beat.emit(beat)

func _on_player_health_changed(): _run_evaluators(lstn_player_health)
func _on_num_approachers_changed(): _run_evaluators(lstn_num_approachers)
func _on_num_shooters_changed(): _run_evaluators(lstn_num_shooters)
func _on_num_chargers_changed(): _run_evaluators(lstn_num_chargers)
#endregion

#region Other functions
func _run_evaluators(evaluators: Array[MusicLayerEvaluator]):
	for evaluator: MusicLayerEvaluator in evaluators:
		var index: int = evaluator.sync_stream_index
		match evaluator.evaluate():
			BT_Node.Status.FAILURE: synced_music_player.set_stream_volume(0.0, index)
			BT_Node.Status.SUCCESS: synced_music_player.set_stream_volume(1.0, index)
			_: pass

func play_sfx(sfx_name: String):
	var sfx: AudioStreamPlayer = sfx_dict[sfx_name]
	if null == sfx: return
	
	if not sfx.playing: sfx.play()
#endregion

# TEMP
var timer = 1.0
func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timer = 1000000000.0
		synced_music_player.set_music_playing(true)
		
		var evaluators: Array[MusicLayerEvaluator]
		evaluators.assign(music_layer_evaluators.find_children("*", "MusicLayerEvaluator", false))
		_run_evaluators(evaluators)
