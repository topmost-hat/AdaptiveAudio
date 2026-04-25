class_name Approacher
extends Enemy

#region Variables
@export var acceleration: float = 100000.0
@export var max_speed: float = 200.0
#endregion

#region Godot functions
func _ready() -> void:
	WorldState.add_fact("NumApproachers", 1)

func _physics_process(delta: float) -> void:
	_chase_target(delta)
#endregion

#region Override functions
func _entity_collision(other: Entity):
	if other is PlayerBullet:
		add_health(-1)
		if 0 >= health: WorldState.add_fact("NumApproachersDefeated", 1)

func _player_collision(player: Player):
	die()
	player.player_health.add_health(-1)

func _other_collision(_body: Node): pass

func die():
	super()
	WorldState.add_fact("NumApproachers", -1)
#endregion

#region Other functions
func _chase_target(delta: float):
	if null == target: return
	apply_force((target.position - position).normalized() * acceleration * delta)
	linear_velocity = linear_velocity.limit_length(max_speed)
#endregion
