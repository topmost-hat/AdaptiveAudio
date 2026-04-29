@abstract
class_name WorldFact
extends Node

signal changed

var type: Variant.Type
var fact :
	set(new_fact):
		if typeof(new_fact) == type:
			fact = new_fact
			changed.emit()
		else:
			push_warning( "Attempted to overwrite \""
				+ name + "\" with fact of incorrect type!")
	get: return type_convert(fact, type)

@abstract func reset()

# this is admittedly a very weird and probably overcomplicated setup
# but it does allow me to add new stuff to WorldState by just adding a new node
# instead of actually writing new code
