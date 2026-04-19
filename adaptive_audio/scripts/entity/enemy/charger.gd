class_name Charger
extends Enemy

#region Variables
@export var beats_between_charges: int = 7
@export var charge_speed: float = 500.0

var beat_timer: int
var charge_impulse: float
#endregion

#region Godot functions
func _ready() -> void:
	AudioManager.music_beat.connect(_on_music_beat)
	WorldState.add_fact("NumChargers", 1)
	
	beat_timer = beats_between_charges + 1
	charge_impulse = charge_speed * mass

func _exit_tree() -> void:
	AudioManager.music_beat.disconnect(_on_music_beat)
	WorldState.add_fact("NumChargers", -1)
	#WorldState.add_fact("NumChargersKilled", 1)
#endregion

#region Override functions
func _entity_collision(other: Entity):
	if other is PlayerBullet:
		add_health(-1)

func _player_collision(_player: Player):
	WorldState.add_fact("PlayerHealth", -1)
	add_health(-1)

func _other_collision(_body: Node): pass
#endregion

#region Other functions
func _on_music_beat(_beat: int):
	beat_timer -= 1
	
	if 1 == beat_timer: pass # TODO: play warning SFX
	elif -1 >= beat_timer:
		beat_timer = beats_between_charges
		_charge()

func _charge():
	if null == target: return
	
	apply_impulse((target.position - position).normalized() * charge_impulse)
#endregion
