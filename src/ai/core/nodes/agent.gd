@icon("../icons/brain.png")
class_name Agent extends HTNP

var percents: Dictionary = {Percents.FOOD_LOCATION: [Vector2i(20, 15)]}
@export var planner: Planner

var plan: Array[Action] = []
var current_action: Action = null


func _ready() -> void:
	TurnManager.next_turn.connect(on_next_turn)


func _process(delta: float) -> void:
	if AssetsReferences.paused:
		return
	if not current_action:
		return
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


func on_next_turn() -> void:
	if not current_action and plan.is_empty():
		plan = get_new_plan()
	if not current_action:
		current_action = plan.pop_front()
		current_action.setup(percents)


## There are three conditions that will force the planner to find a new plan:
## 1. The agent finishes or fails the current plan
## 2. The agent does not have a plan
## 3. The agent's percents changes via a sensor
func get_new_plan() -> Array[Action]:
	var new_plan = planner.decompose(percents.duplicate(true))
	return new_plan
