class_name MoveToTileAction extends Action

@export var direction: Vector2
@export var body: CharacterBody2D
@export var speed: float = 50.0

var target: Vector2


func setup(_percents: Dictionary) -> void:
	target = body.position + (direction * 16)


func validate_execution() -> bool:
	return true


func validate_preconditions(_agent_state: Dictionary) -> bool:
	return true


func execute(delta: float) -> Status:
	if body.position.distance_squared_to(target) < 0.5:
		body.position = target
		return Status.Succeeded
	body.position = body.position.move_toward(target, speed * delta)
	return Status.Running
