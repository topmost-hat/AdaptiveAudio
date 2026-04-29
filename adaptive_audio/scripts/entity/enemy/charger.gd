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
#endregion

#region Override functions
func _entity_collision(other: Entity):
	if other is PlayerBullet:
		add_health(-1)
		if 0 >= health: WorldState.add_fact("NumChargersDefeated", 1)

func _player_collision(player: Player):
	add_health(-1)
	player.player_health.add_health(-1)

func _other_collision(_body: Node): pass

func die():
	super()
	WorldState.add_fact("NumChargers", -1)
#endregion

#region Other functions
func _on_music_beat(_beat: int):
	beat_timer -= 1
	
	# play a warning sound before charging
	# warning sounds can overlap if multiple chargers play them at offset times
	if 2 == beat_timer: AudioManager.play_calliope()
	elif -1 >= beat_timer:
		beat_timer = beats_between_charges
		_charge()

func _charge():
	if null == target: return
	
	apply_impulse((target.position - position).normalized() * charge_impulse)
#endregion
