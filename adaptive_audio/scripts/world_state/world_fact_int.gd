class_name WorldFactInt
extends WorldFact

@export var default: int

func _ready() -> void:
	type = Variant.Type.TYPE_INT
	fact = default

func reset(): fact = default
