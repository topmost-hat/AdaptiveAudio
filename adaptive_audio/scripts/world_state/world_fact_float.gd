class_name WorldFactFloat
extends WorldFact

@export var default: float

func _ready() -> void:
	type = Variant.Type.TYPE_FLOAT
	fact = default

func reset(): fact = default
