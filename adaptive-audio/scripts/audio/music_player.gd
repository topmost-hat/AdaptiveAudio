class_name MusicPlayer
extends AudioStreamPlayer

func _ready() -> void:
	WorldState.game_paused_changed.connect(rcvd_game_paused)

func rcvd_game_paused():
	if WorldState.get_game_paused(): set_volume(-6.0)
	else: set_volume(0.0)

func play_music(playMusic: bool): playing = playMusic
func set_volume(volumeDB: float): volume_db = clampf(volumeDB, -80.0, 0.0)
