# Modified from a personal project by Atticus Clark

class_name Player
extends CharacterBody2D

@export var reload_beat_mod: int = 8

@onready var player_input: PlayerInput = $PlayerInput
@onready var player_movement: PlayerMovement = $PlayerMovement
@onready var player_shoot: PlayerShoot = $PlayerShoot

func _ready() -> void:
	AudioManager.music_beat.connect(_on_music_beat)

func _exit_tree() -> void:
	AudioManager.music_beat.disconnect(_on_music_beat)

func _physics_process(_delta: float):
	velocity = player_movement.move(velocity)
	move_and_slide()

func _on_mouse_click(pressed: bool):
	if pressed: player_shoot.shoot(position, get_viewport().get_mouse_position())

func _on_music_beat(_beat: int):
	if (_beat - 1) % reload_beat_mod == 0: player_shoot.reload()
