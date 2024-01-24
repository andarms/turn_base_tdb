@icon("../icons/action.png")
class_name Action extends HTNP

enum Status { Running, Failed, Succeeded }


func setup(percents: Dictionary) -> void:
	pass


func execute(_delta: float) -> Status:
	return Status.Running


func cleanup() -> void:
	pass
