extends Node

var sync_stream: AudioStreamSynchronized
var music_loop_time: float

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var enemy_spawn_sfx_high: AudioStreamPlayer = $EnemySpawnSFXHigh
@onready var enemy_spawn_sfx_mid: AudioStreamPlayer = $EnemySpawnSFXMid
@onready var enemy_spawn_sfx_low: AudioStreamPlayer = $EnemySpawnSFXLow
@onready var button_sfx: AudioStreamPlayer = $ButtonSFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sync_stream = music_player.stream as AudioStreamSynchronized
	for i in sync_stream.stream_count:
		music_loop_time = maxf(music_loop_time, sync_stream.get_sync_stream(i).get_length())

func play_music(playing: bool) -> void:
	music_player.playing = playing

func set_enemy_layer_volume(enemy_type: WorldState.EnemyType, volume: float) -> void:
	if 0 > enemy_type or sync_stream.stream_count <= enemy_type: return
	sync_stream.set_sync_stream_volume(enemy_type, volume)

func play_spawn_sfx(enemy_type: WorldState.EnemyType) -> void:
	match enemy_type:
		WorldState.EnemyType.APPROACHER: enemy_spawn_sfx_high.play()
		WorldState.EnemyType.SHOOTER: enemy_spawn_sfx_mid.play()
		WorldState.EnemyType.CHARGER: enemy_spawn_sfx_low.play()

func play_button_sfx() -> void:
	button_sfx.play()
