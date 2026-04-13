class_name DifficultyInfo
extends Resource

@export_group("Spawn Aggression")
@export var min_beats_between_waves: int
@export var max_enemies_in_wave: int

@export_group("Enemy Maximums", "max_")
@export var max_approachers: int
@export var max_shooters: int
@export var max_chargers: int

func get_max_enemies() -> int: return max_approachers + max_shooters + max_chargers
