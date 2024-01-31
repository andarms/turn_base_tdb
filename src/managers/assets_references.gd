extends Node

var damage_indicator = preload("res://src/components/damage_indicator/damage_indicator.tscn")


func create_damage_indicator(position: Vector2, damage: int):
	var damage_indicator_instance = damage_indicator.instantiate()
	get_tree().get_root().add_child(damage_indicator_instance)
	damage_indicator_instance.position = position
	damage_indicator_instance.set_damage(damage)
