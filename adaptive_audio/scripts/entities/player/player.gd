# Taken from a personal project by Atticus Clark

class_name Player
extends CharacterBody2D

@onready var player_input: PlayerInput = $PlayerInput
@onready var player_movement: PlayerMovement = $PlayerMovement
@onready var player_shoot: PlayerShoot = $PlayerShoot

func _physics_process(_delta: float):
	velocity = player_movement.move(velocity)
	move_and_slide()

func _on_player_input_input_lmb(pressed: bool, click_pos: Vector2) -> void:
	if pressed: player_shoot.shoot(position, click_pos)
