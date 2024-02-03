@icon("../icons/compound_action.png")
class_name CompundAction extends HTNP

enum COMPOUND_TYPE { Sequence, Selection }

@export var type: COMPOUND_TYPE = COMPOUND_TYPE.Selection

var _actions: Array[HTNP] = []


func _ready() -> void:
	var children = get_children().filter(func(child_action): return child_action is HTNP)
	for child_action in children:
		_actions.append(child_action)


func decompose(agent_state: Dictionary) -> Array[Action]:
	match type:
		COMPOUND_TYPE.Selection:
			return decompose_selection(agent_state)
		COMPOUND_TYPE.Sequence:
			return decompose_sequence(agent_state)
		_:
			return []


func decompose_sequence(agent_state: Dictionary) -> Array[Action]:
	var valid_actions: Array[Action] = []
	for child_action in _actions:
		if child_action is Action and validate_action(child_action, agent_state):
			valid_actions.append(child_action)
		else:
			return []
		if child_action is CompundAction:
			valid_actions.append_array(child_action.decompose(agent_state))
	return valid_actions


func decompose_selection(agent_state: Dictionary) -> Array[Action]:
	for child_action in _actions:
		if child_action is Action and validate_action(child_action, agent_state):
			return [child_action]
		if child_action is CompundAction:
			var result = child_action.decompose(agent_state.duplicate(true))
			if not result.is_empty():
				return result
	return []


func validate_action(action: Action, agent_state: Dictionary):
	var valid = action.validate_execution() and action.validate_preconditions(agent_state)
	if valid:
		action.apply_effects(agent_state)
	return valid


func validate(percents: Dictionary):
	return self.validate_execution() and self.validate_preconditions(percents)


func validate_execution() -> bool:
	return true


func validate_preconditions(_percents) -> bool:
	return true
