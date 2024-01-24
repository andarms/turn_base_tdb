@icon("../icons/brain.png")
class_name Agent extends HTNP

var percents: Dictionary = {Percents.FOOD_LOCATION: [Vector2i(20, 15)]}
# Percents.TARGET: Vector2i(19, 3)
@export var planner: Planner

var plan: Array[Action] = []
var current_action: Action = null


func _process(delta: float) -> void:
	if not current_action and plan.is_empty():
		plan = get_new_plan()
	if not current_action:
		current_action = plan.pop_front()
		current_action.setup(percents)
	var valid = current_action.validate_preconditions(percents)
	if not valid:
		return
	var status = current_action.execute(delta)
	match status:
		Action.Status.Failed:
			current_action = null
			plan = []
		Action.Status.Succeeded:
			current_action.cleanup()
			current_action.apply_effects(percents)
			current_action = null
		_:
			return


## There are three conditions that will force the planner to find a new plan:
## 1. The agent finishes or fails the current plan
## 2. The agent does not have a plan
## 3. The agent's percents changes via a sensor
func get_new_plan() -> Array[Action]:
	print("Creating new plan")
	var new_plan = planner.decompose(percents.duplicate(true))
	print("plan = ", new_plan)
	return new_plan