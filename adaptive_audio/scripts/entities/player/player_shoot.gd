class_name PlayerShoot
extends Node

@export var cone_angle_rad: float

var player_bullet = preload("res://scenes/entities/player/player_bullet.tscn")

func shoot(origin: Vector2, target: Vector2):
	var bullet = (player_bullet.instantiate() as PlayerBullet)
	bullet.position = origin
	bullet.direction = (target - origin).normalized()
	add_child(bullet)
	
	var cos_cone_angle: float = cos(cone_angle_rad)
	var sin_cone_angle: float = sin(cone_angle_rad)
	
	var bullet_left = (player_bullet.instantiate() as PlayerBullet)
	bullet_left.position = origin
	bullet_left.direction.x = (
		bullet.direction.x * cos_cone_angle
		- bullet.direction.y * sin_cone_angle
	)
	bullet_left.direction.y = (
		bullet.direction.x * sin_cone_angle
		+ bullet.direction.y * cos_cone_angle
	)
	add_child(bullet_left)
	
	var cos_cone_angle_minus: float = cos(-cone_angle_rad)
	var sin_cone_angle_minus: float = sin(-cone_angle_rad)
	
	var bullet_right = (player_bullet.instantiate() as PlayerBullet)
	bullet_right.position = origin
	bullet_right.direction.x = (
		bullet.direction.x * cos_cone_angle_minus
		- bullet.direction.y * sin_cone_angle_minus
	)
	bullet_right.direction.y = (
		bullet.direction.x * sin_cone_angle_minus
		+ bullet.direction.y * cos_cone_angle_minus
	)
	add_child(bullet_right)
