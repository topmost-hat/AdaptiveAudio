class_name Shooter
extends Enemy

#region Variables
# These aren't totally independent...you probably just need
# to play around with them a bit to get the timing you want
@export var beats_between_bursts: int = 1
@export var beats_between_bullets: int = 0
@export var bullets_per_burst: int = 3

# dumb fix for player not colliding with this properly
@export var acceleration: float = 100000.0
@export var max_speed: float = 0.1

var burst_beats: int
var bullet_beats: int
var bullets_left: int

var bullet = preload("res://scenes/entity/bullet/enemy_bullet.tscn")
#endregion

#region Godot functions
func _ready() -> void:
	AudioManager.music_beat.connect(_on_music_beat)
	WorldState.add_fact("NumShooters", 1)
	
	bullets_left = bullets_per_burst

func _exit_tree() -> void:
	AudioManager.music_beat.disconnect(_on_music_beat)

func _physics_process(delta: float) -> void:
	_chase_target(delta)
#endregion

#region Override functions
func _entity_collision(other: Entity):
	if other is PlayerBullet:
		add_health(-1)
		if 0 >= health: WorldState.add_fact("NumShootersDefeated", 1)

func _player_collision(player: Player):
	die()
	player.player_health.add_health(-1)

func _other_collision(_body: Node): pass

func die():
	super()
	WorldState.add_fact("NumShooters", -1)
#endregion

#region Other functions
func _on_music_beat(_beat: int):
	burst_beats -= 1
	if 0 <= burst_beats: return
	
	bullet_beats -= 1
	if 0 <= bullet_beats: return
	
	_shoot()
	bullet_beats = beats_between_bullets
	bullets_left -= 1
	if 1 <= bullets_left: return
	
	burst_beats = beats_between_bursts
	bullet_beats = 0
	bullets_left = bullets_per_burst

func _shoot():
	if null == target: return
	
	var new_bullet: Bullet = (bullet.instantiate() as Bullet)
	new_bullet.position = position
	new_bullet.direction = target.position - position
	get_tree().root.add_child(new_bullet)

func _chase_target(delta: float):
	if null == target: return
	apply_force((target.position - position).normalized() * acceleration * delta)
	linear_velocity = linear_velocity.limit_length(max_speed)
#endregion
