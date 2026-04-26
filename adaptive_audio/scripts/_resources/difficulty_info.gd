class_name DifficultyInfo
extends Resource

@export var beats_to_next_difficulty: int = 32
@export var beats_between_waves: int
@export var beats_between_spawns: int
@export var enemies_per_wave: int = 1
@export var spawn_queue: Array[Enemy.Type]

var _max_approachers: int = 0
var _max_shooters: int = 0
var _max_chargers: int = 0

func count_enemies() -> void:
	for i in spawn_queue.size():
		match spawn_queue[i]:
			Enemy.Type.APPROACHER: _max_approachers += 1
			Enemy.Type.SHOOTER: _max_shooters += 1
			Enemy.Type.CHARGER: _max_chargers += 1

func max_enemies_of_type(type: Enemy.Type) -> int:
	match type:
		Enemy.Type.APPROACHER: return _max_approachers
		Enemy.Type.SHOOTER: return _max_shooters
		Enemy.Type.CHARGER: return _max_chargers
	
	return -1
