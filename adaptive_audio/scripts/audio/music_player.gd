class_name MusicPlayer
extends AudioStreamPlayer

signal music_beat()

# music is currently 144 BPM JUST KIDDING IT'S 72 BPM
# hardcoding could be replaced with a smarter solution, but this works fine for now
const BEAT_TIME: float = 60.0 / 72.0
var output_latency: float

var prev_playback_time: float = 0.0
var beat_timer: float = 0.0

func _ready() -> void:
	output_latency = AudioServer.get_output_latency()
	
	WorldState.game_paused_changed.connect(rcvd_game_paused)
	WorldState.player_health_changed.connect(rcvd_player_health)
	
	play()

func _process(_delta: float) -> void:
	var playback_time = (
		get_playback_position()
		+ AudioServer.get_time_since_last_mix()
		- output_latency
	)
	var time_step: float = playback_time - prev_playback_time
	if(0.0 > time_step and time_step > -0.1): return # filter audio thread jitter
	prev_playback_time = playback_time
	
	beat_timer += time_step
	if beat_timer >= BEAT_TIME:
		beat_timer -= BEAT_TIME
		music_beat.emit()
	while beat_timer < 0: beat_timer += BEAT_TIME

func rcvd_game_paused():
	if WorldState.get_game_paused(): volume_db = -0.6
	else: volume_db = 0.0

func rcvd_player_health():
	var playerHealth: int = WorldState.get_player_health()
	if playing and 0 >= playerHealth: stop()
	elif not playing and 0 < playerHealth: play()
