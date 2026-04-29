class_name NestedDiscretePassthruClock
extends Node

signal timeout(layer: int)

@export var default_delays: Array[int]
var clocks: Array[int]

func _ready():
	clocks.assign(default_delays)

func tick():
	for i: int in clocks.size():
		clocks[i] -= 1
		if 0 >= clocks[i]: timeout.emit(i)
		else: return
	clocks.assign(default_delays)

# this isn't used anywhere. i was hoping to use it for Shooter and
# EnemyManager, but they needed something slightly more complex
# and it was easier to just leave it within those classes
