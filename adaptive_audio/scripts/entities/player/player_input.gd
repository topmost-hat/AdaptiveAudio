# Modified from a personal project by Atticus Clark

class_name PlayerInput
extends Node

signal input_right(pressed: bool)
signal input_left(pressed: bool)
signal input_down(pressed: bool)
signal input_up(pressed: bool)

# !!! Remember to replace "ui" input actions with your own input actions !!!
@export_group("Input Action Names", "ACTION_NAME_")
@export var ACTION_NAME_RIGHT: String = "ui_right"
@export var ACTION_NAME_LEFT: String = "ui_left"
@export var ACTION_NAME_DOWN: String = "ui_down"
@export var ACTION_NAME_UP: String = "ui_up"

var right_inputs: int = 0
var left_inputs: int = 0
var down_inputs: int = 0
var up_inputs: int = 0

func _unhandled_input(event: InputEvent):
	# TODO OPTIONAL: if LOCAL multiplayer is desired, use event.device to
	# determine which controller this input event came from, and exit function
	# early if it does not correspond to this player
	
	# pressed
	if event.is_action_pressed(ACTION_NAME_RIGHT):
		right_inputs += 1
		if 1 == right_inputs: input_right.emit(true)
	elif event.is_action_pressed(ACTION_NAME_LEFT):
		left_inputs += 1
		if 1 == left_inputs: input_left.emit(true)
	elif event.is_action_pressed(ACTION_NAME_DOWN):
		down_inputs += 1
		if 1 == down_inputs: input_down.emit(true)
	elif event.is_action_pressed(ACTION_NAME_UP):
		up_inputs += 1
		if 1 == up_inputs: input_up.emit(true)
	
	# released
	elif event.is_action_released(ACTION_NAME_RIGHT):
		right_inputs -= 1
		if 0 == right_inputs: input_right.emit(false)
	elif event.is_action_released(ACTION_NAME_LEFT):
		left_inputs -= 1
		if 0 == left_inputs: input_left.emit(false)
	elif event.is_action_released(ACTION_NAME_DOWN):
		down_inputs -= 1
		if 0 == down_inputs: input_down.emit(false)
	elif event.is_action_released(ACTION_NAME_UP):
		up_inputs -= 1
		if 0 == up_inputs: input_up.emit(false)
