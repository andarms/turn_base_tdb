class_name HTNP extends Node


## This method is called both in the planning phase and just before executing the action.
func validate_execution() -> bool:
	print("This method is meant to be overridden by subclasses")
	return false


func validate_preconditions(agent_state: Dictionary) -> bool:
	print("This method is meant to be overridden by subclasses")
	return false


func apply_effects(agent_state: Dictionary) -> void:
	print("This method is meant to be overridden by subclasses")
	pass
