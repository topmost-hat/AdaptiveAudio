extends Node

#region Variables
var fact_dict: Dictionary[String, WorldFact]
#endregion

#region Godot functions
func _ready() -> void:
	for child in get_children():
		if child is WorldFact:
			fact_dict[child.name] = child as WorldFact
#endregion

#region WorldFact functions
func validate_fact(fact_name: String) -> bool:
	if fact_dict.has(fact_name): return true
	
	push_warning("Could not find fact \"" + fact_name + "\"!")
	return false

func connect_to_fact(fact_name: String, callable: Callable, disconnecting: bool = false):
	if not validate_fact(fact_name): return
	
	var sig: Signal = fact_dict[fact_name].changed
	if sig.is_connected(callable): return
	
	if not disconnecting: sig.connect(callable)
	else: sig.disconnect(callable)

func get_fact(fact_name: String) -> Variant:
	if not validate_fact(fact_name): return
	
	return fact_dict[fact_name].fact

func set_fact(fact_name: String, new_fact):
	if not validate_fact(fact_name): return
	
	fact_dict[fact_name].fact = new_fact

func add_fact(fact_name: String, to_add):
	if not validate_fact(fact_name): return
	
	fact_dict[fact_name].fact += to_add

func reset_fact(fact_name: String):
	if not validate_fact(fact_name): return
	
	fact_dict[fact_name].reset()
#endregion

#region Other functions
func reset_all_facts():
	for fact: WorldFact in fact_dict.values(): fact.reset()
#endregion
