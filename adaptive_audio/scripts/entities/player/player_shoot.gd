class_name PlayerShoot
extends Node

var player_bullet = preload("res://scenes/entities/player/player_bullet.tscn")

func shoot(origin: Vector2, target: Vector2):
	var bullet = (player_bullet.instantiate() as PlayerBullet)
	bullet.position = origin
	bullet.direction = (target - origin).normalized()
	add_child(bullet)
