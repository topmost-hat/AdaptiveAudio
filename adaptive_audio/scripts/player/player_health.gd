class_name PlayerHealth
extends Node

signal died
@export var health: int = 3

func _ready():
	WorldState.set_fact("PlayerHealth", health)

func add_health(amount: int):
	health += amount
	WorldState.set_fact("PlayerHealth", health)
	if 0 >= health: died.emit()
