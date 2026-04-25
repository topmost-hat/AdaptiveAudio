extends Node

var player_template = preload("res://scenes/player.tscn")

@onready var gui: GUI = $GUI
@onready var enemy_manager: EnemyManager = $World/EnemyManager
@onready var stopwatch: Stopwatch = $World/Stopwatch

func _ready():
	WorldState.connect_to_fact("PlayerHealth", _on_player_health_changed)
	WorldState.connect_to_fact("PlayerAmmo", _on_player_ammo_changed)

func _on_player_health_changed():
	gui.update_health_ui()
	if 0 >= WorldState.get_fact("PlayerHealth"): _game_over()
	
func _on_player_ammo_changed(): gui.update_ammo_ui()

func _start_game():
	var player: Player = player_template.instantiate()
	player.position = Vector2(960.0, 540.0) # stinky hardcoding
	enemy_manager.player = player
	add_child(player)
	
	gui.start_game()
	
	stopwatch.reset()
	stopwatch.start()
	AudioManager.start_music()

func _game_over():
	AudioManager.stop_music()
	stopwatch.stop()
	
	gui.game_over(stopwatch.get_time())
	
	enemy_manager.reset()
	WorldState.reset_all_facts()
