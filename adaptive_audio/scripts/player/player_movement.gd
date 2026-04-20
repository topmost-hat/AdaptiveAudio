# Modified from a personal project by Atticus Clark
# Primarily based on video by MakerTech: https://www.youtube.com/watch?v=eTVT1KFToCQ
# Jump cut based on video by Dawnosaur: https://www.youtube.com/watch?v=KbtcEVCM7bw

class_name PlayerMovement
extends Node

#region Variables
@export var TARGET_SPEED: float
@export var ACCELERATION: float
@export var DECELERATION: float
@export var TURNAROUND: float

var x_input: int = 0
var y_input: int = 0
#endregion

#region Godot functions
func _ready():
	get_window().focus_exited.connect(_reset)
#endregion

#region Input signalled functions
func on_input_right(pressed: bool):
	if pressed: x_input += 1
	else: x_input -= 1

func on_input_left(pressed: bool):
	if pressed: x_input -= 1
	else: x_input += 1

func on_input_down(pressed: bool):
	if pressed: y_input += 1
	else: y_input -= 1

func on_input_up(pressed: bool):
	if pressed: y_input -= 1
	else: y_input += 1
#endregion

#region Other functions
func _reset():
	x_input = 0
	y_input = 0

func move(velocity: Vector2) -> Vector2:
	var x_dir: int = signi(x_input)
	var y_dir: int = signi(y_input)
	
	var accel_x: float = ACCELERATION
	if 0 == x_dir: accel_x = DECELERATION
	elif not is_equal_approx(signf(velocity.x), x_dir): accel_x = TURNAROUND
	
	var accel_y: float = ACCELERATION
	if 0 == y_dir: accel_y = DECELERATION
	elif not is_equal_approx(signf(velocity.y), y_dir): accel_y = TURNAROUND
	
	velocity.x = move_toward(velocity.x, x_dir * TARGET_SPEED, accel_x)
	velocity.y = move_toward(velocity.y, y_dir * TARGET_SPEED, accel_y)
	
	return velocity
#endregion
