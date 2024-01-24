class_name Sensor extends Area2D

@export var agent: Agent


func _ready() -> void:
	agent.percents[Percents.TARGET] = Vector2i(0, 0)
