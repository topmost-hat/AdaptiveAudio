class_name WorldFactBool
extends WorldFact

@export var default: bool

func _ready() -> void:
	type = Variant.Type.TYPE_BOOL
	fact = default

func reset(): fact = default
