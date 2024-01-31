class_name HurtBox extends Area2D

@export var healt: Health


func take_damage(damage):
	print("HurtBox: take_damage")
	healt.take_damage(damage)
