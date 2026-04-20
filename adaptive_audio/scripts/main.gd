extends Node

@export var start_time: float = 1.0
var start_timer: Timer

func _ready() -> void:
	start_timer = Timer.new()
	add_child(start_timer)
	start_timer.timeout.connect(_start_music)
	start_timer.start(start_time)

func _start_music() -> void:
	AudioManager.start_music()
	start_timer.queue_free()
