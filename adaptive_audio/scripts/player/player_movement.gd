# Modified from a personal project by Atticus Clark
# Primarily based on video by MakerTech: https://www.youtube.com/watch?v=eTVT1KFToCQ
# Jump cut based on video by Dawnosaur: https://www.youtube.com/watch?v=KbtcEVCM7bw

class_name PlayerMovement
extends Node

#region Variables
@export var TARGET_SPEED: float
@export var MAX_SPEED: float
@export var ACCELERATION: float
@export var DECELERATION: float
@export var TURNAROUND: float

var desiredDirX: int = 0
var desiredDirY: int = 0
#endregion

#region Input signalled functions
func on_input_right(pressed: bool):
	if pressed: desiredDirX += 1
	else: desiredDirX -= 1

func on_input_left(pressed: bool):
	if pressed: desiredDirX -= 1
	else: desiredDirX += 1

func on_input_up(pressed: bool):
	if pressed: desiredDirY -= 1
	else: desiredDirY += 1

func on_input_down(pressed: bool):
	if pressed: desiredDirY += 1
	else: desiredDirY -= 1
#endregion

#region Movement functions
func move(velocity: Vector2) -> Vector2:
	velocity.x = clampf(velocity.x, -MAX_SPEED, MAX_SPEED)
	velocity.y = clampf(velocity.y, -MAX_SPEED, MAX_SPEED)
	
	var accelX: float = ACCELERATION
	if 0 == desiredDirX: accelX = DECELERATION
	elif signf(velocity.x) != desiredDirX: accelX = TURNAROUND
	
	var accelY: float = ACCELERATION
	if 0 == desiredDirY: accelY = DECELERATION
	elif signf(velocity.y) != desiredDirY: accelY = TURNAROUND
	
	velocity.x = move_toward(velocity.x, desiredDirX * TARGET_SPEED, accelX)
	velocity.y = move_toward(velocity.y, desiredDirY * TARGET_SPEED, accelY)
	
	return velocity
#endregion
