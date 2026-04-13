# Taken from a personal project by Atticus Clark

class_name Player
extends CharacterBody2D

@onready var player_input: PlayerInput = $PlayerInput
@onready var player_movement: PlayerMovement = $PlayerMovement

func _physics_process(_delta: float):
	velocity = player_movement.move(velocity)
	move_and_slide()
