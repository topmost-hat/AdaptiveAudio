# Modified from a personal project by Atticus Clark

class_name PlayerInput
extends Node

signal input_right(pressed: bool)
signal input_left(pressed: bool)
signal input_down(pressed: bool)
signal input_up(pressed: bool)
signal input_lmb(pressed: bool)

# !!! Remember to replace "ui" input actions with your own input actions !!!
@export_group("Input Action Names", "ACTION_NAME_")
@export var ACTION_NAME_RIGHT: String = "ui_right"
@export var ACTION_NAME_LEFT: String = "ui_left"
@export var ACTION_NAME_DOWN: String = "ui_down"
@export var ACTION_NAME_UP: String = "ui_up"

var right_inputs: bool = false
var left_inputs: bool = false
var down_inputs: bool = false
var up_inputs: bool = false

func _unhandled_input(event: InputEvent):
	# TODO OPTIONAL: if LOCAL multiplayer is desired, use event.device to
	# determine which controller this input event came from, and exit function
	# early if it does not correspond to this player
	
	# filter out echo events
	if event.is_echo(): return
	
	# mouse
	if event is InputEventMouseButton:
		if MOUSE_BUTTON_LEFT == event.button_index:
			input_lmb.emit(event.pressed)
	
	# keyboard
	elif event.is_action(ACTION_NAME_RIGHT): input_right.emit(event.is_pressed())
	elif event.is_action(ACTION_NAME_LEFT): input_left.emit(event.is_pressed())
	elif event.is_action(ACTION_NAME_DOWN): input_down.emit(event.is_pressed())
	elif event.is_action(ACTION_NAME_UP): input_up.emit(event.is_pressed())
