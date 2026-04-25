class_name PlayerShoot
extends Node

signal player_shot

@export var max_ammo: int = 8
@export var reload_amount: int = 6

var bullet = preload("res://scenes/entity/bullet/player_bullet.tscn")
var ammo: int

func _ready() -> void:
	ammo = max_ammo

func shoot(origin: Vector2, target: Vector2):
	if 0 >= ammo: return
	ammo -= 1
	WorldState.set_fact("PlayerAmmo", ammo)
	WorldState.add_fact("PlayerShotsFired", 1)
	
	var new_bullet: Bullet = (bullet.instantiate() as Bullet)
	new_bullet.position = origin
	new_bullet.direction = target - origin
	get_tree().root.add_child(new_bullet)
	
	player_shot.emit()

func reload():
	ammo = clampi(ammo + reload_amount, 0, max_ammo)
	WorldState.set_fact("PlayerAmmo", ammo)
