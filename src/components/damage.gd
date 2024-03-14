class_name Damage extends Node

@export var amount: int = 0

func calcaulate_damage() -> Array[int]:
	var calculated = amount
	var critial = randi() % 100
	if is_critical(critial):
		calculated *= 2
	return [calculated, critial]

func is_critical(critical: int) -> bool:
	return critical < 10
