@abstract
class_name Entity
extends Area2D

@export var health: int = 1

@onready var sprite_2d: Sprite2D = $Sprite2D

@abstract func hit(other: Node2D)

func add_health(add: int):
	health += add
	if 0 >= health: queue_free()
