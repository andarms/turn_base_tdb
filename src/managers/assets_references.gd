extends Node

var damage_indicator = preload("res://src/components/damage_indicator/damage_indicator.tscn")
var paused = false


func back_to_main_menu():
	get_tree().change_scene_to_file("res://src/screens/main_menu/main_menu.tscn")


func create_damage_indicator(position: Vector2, damage: int):
	var damage_indicator_instance = damage_indicator.instantiate()
	get_tree().get_root().add_child(damage_indicator_instance)
	damage_indicator_instance.position = position
	damage_indicator_instance.set_damage(damage)
