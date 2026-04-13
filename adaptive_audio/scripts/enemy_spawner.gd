extends Node

@export var player: Player
@export var player_safe_radius: float
@export var difficultyInfo: Array[DifficultyInfo]

var approacher = preload("res://scenes/entities/enemies/approacher.tscn")
var shooter = preload("res://scenes/entities/enemies/shooter.tscn")
var charger = preload("res://scenes/entities/enemies/charger.tscn")

var difficulty: int = 4
var cooldown_beats: int = 0

func _on_music_beat():
	WorldState.reset_spawning_approacher()
	WorldState.reset_spawning_shooter()
	WorldState.reset_spawning_charger()
	
	cooldown_beats -= 1
	if 0 >= cooldown_beats:
		spawn_wave()
		cooldown_beats = difficultyInfo[difficulty].min_beats_between_waves

func spawn_wave():
	var enemies_remaining: int = difficultyInfo[difficulty].max_enemies_in_wave
	while 0 < enemies_remaining:
		var spawned_enemy: bool = false
		if WorldState.get_num_chargers() < difficultyInfo[difficulty].max_chargers:
			spawn_charger(select_spawn_pos())
			enemies_remaining -= 1
			spawned_enemy = true
			if 0 >= enemies_remaining: return
		if WorldState.get_num_shooters() < difficultyInfo[difficulty].max_shooters:
			spawn_shooter(select_spawn_pos())
			enemies_remaining -= 1
			spawned_enemy = true
			if 0 >= enemies_remaining: return
		if WorldState.get_num_approachers() < difficultyInfo[difficulty].max_approachers:
			spawn_approacher(select_spawn_pos())
			enemies_remaining -= 1
			spawned_enemy = true
			if 0 >= enemies_remaining: return
		if not spawned_enemy: return # at max enemies of all types

func spawn_approacher(position: Vector2):
	var instance: Approacher = approacher.instantiate() as Approacher
	instance.position = position
	instance.target = player
	add_child(instance)
	WorldState.set_spawning_approacher(true)

func spawn_shooter(position: Vector2):
	var instance: Shooter = shooter.instantiate() as Shooter
	instance.position = position
	instance.target = player
	add_child(instance)
	WorldState.set_spawning_shooter(true)

func spawn_charger(position: Vector2):
	var instance: Charger = charger.instantiate() as Charger
	instance.position = position
	instance.target = player
	add_child(instance)
	WorldState.set_spawning_charger(true)

func select_spawn_pos() -> Vector2:
	var position: Vector2 = Vector2(randf_range(32.0, 768.0), randf_range(32.0, 418.0))
	var from_player: Vector2 = position - player.position
	if absf(from_player.length()) < player_safe_radius:
		position = player.position + (from_player.normalized() * player_safe_radius)
		if position.x < 32.0 or position.x > 768.0 or position.y < 32.0 or position.y > 418.0:
			position -= from_player.normalized() * 2
	return position
