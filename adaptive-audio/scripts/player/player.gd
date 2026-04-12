# Taken from a personal project by Atticus Clark

extends CharacterBody2D

#region OnReady
@onready var player_input: PlayerInput = $PlayerInput
@onready var player_movement: PlayerMovement = $PlayerMovement
#endregion

#region Godot functions
func _physics_process(_delta: float):
	velocity = player_movement.move(velocity)
	move_and_slide()
#endregion
