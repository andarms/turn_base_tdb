class_name Health extends Node2D

signal dead

@export var max_health: int
@export var current: int

func _ready():
	current = max_health

func _process(_delta):
	if current <= 0:
		dead.emit()

func take_damage(damage: int):
	current -= damage
	if current <= 0:
		dead.emit()
