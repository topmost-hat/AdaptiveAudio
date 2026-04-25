class_name Stopwatch
extends Node

@export var _active: bool = false
@export var _time: float = 0.0

func _process(delta: float):
	_time += delta * (_active as float)

func start(): _active = true
func stop(): _active = false
func reset(): _time = 0.0
func get_time() -> float: return _time
