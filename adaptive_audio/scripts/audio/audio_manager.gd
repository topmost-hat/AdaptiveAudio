extends Node

#region Variables
signal music_beat(beat: int)

# which evaluators should listen to which WorldState changes
@export var lstn_beat_count: Array[MusicLayerEvaluator]
@export var lstn_difficulty: Array[MusicLayerEvaluator]
@export var lstn_player_health: Array[MusicLayerEvaluator]
@export var lstn_num_approachers: Array[MusicLayerEvaluator]
@export var lstn_num_shooters: Array[MusicLayerEvaluator]
@export var lstn_num_chargers: Array[MusicLayerEvaluator]

var _sfx_dict: Dictionary[String, AudioStreamPlayer]
var _evaluators: Array[MusicLayerEvaluator]

@onready var _synced_music_player: SyncedMusicPlayer = $SyncedMusicPlayer
@onready var _music_layer_evaluators: Node = $MusicLayerEvaluators
@onready var _sfx_players: Node = $SFXPlayers
@onready var _calliope_player: BeatCycleSFXPool = $CalliopePlayer
#endregion

#region Godot functions
func _ready() -> void:
	for player in _sfx_players.get_children():
		if player is AudioStreamPlayer:
			_sfx_dict[player.name] = player as AudioStreamPlayer
	
	_evaluators.assign(_music_layer_evaluators.find_children("*", "MusicLayerEvaluator", false))
	
	WorldState.connect_to_fact("Difficulty", _on_difficulty_changed)
	WorldState.connect_to_fact("PlayerHealth", _on_player_health_changed)
	WorldState.connect_to_fact("NumApproachers", _on_num_approachers_changed)
	WorldState.connect_to_fact("NumShooters", _on_num_shooters_changed)
	WorldState.connect_to_fact("NumChargers", _on_num_chargers_changed)
#endregion

#region Signal receiver functions
func _on_music_beat(beat: int) -> void:
	_run_evaluators(lstn_beat_count)
	music_beat.emit(beat)

func _on_difficulty_changed(): _run_evaluators(lstn_difficulty)
func _on_player_health_changed(): _run_evaluators(lstn_player_health)
func _on_num_approachers_changed(): _run_evaluators(lstn_num_approachers)
func _on_num_shooters_changed(): _run_evaluators(lstn_num_shooters)
func _on_num_chargers_changed(): _run_evaluators(lstn_num_chargers)
#endregion

#region Other functions
func _run_evaluators(evaluators: Array[MusicLayerEvaluator], instant: bool = false):
	for evaluator: MusicLayerEvaluator in evaluators:
		var index: int = evaluator.sync_stream_index
		if instant:
			match evaluator.evaluate():
				BT_Node.Status.FAILURE: _synced_music_player.set_stream_volume(0.0, index)
				BT_Node.Status.SUCCESS: _synced_music_player.set_stream_volume(1.0, index)
				_: pass
		else:
			match evaluator.evaluate():
				BT_Node.Status.FAILURE: _synced_music_player.fade_out_stream(index)
				BT_Node.Status.SUCCESS: _synced_music_player.fade_in_stream(index)
				_: pass

func start_music():
	_run_evaluators(_evaluators, true)
	_synced_music_player.set_music_playing(true)

func stop_music(): _synced_music_player.set_music_playing(false)

func play_sfx(sfx_name: String):
	var sfx: AudioStreamPlayer = _sfx_dict[sfx_name]
	if null == sfx: return
	
	if not sfx.playing: sfx.play()

func play_calliope(): _calliope_player.play_sfx()

func get_beat_count() -> int: return _synced_music_player.get_beat_count()
#endregion
