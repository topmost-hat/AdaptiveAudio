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
