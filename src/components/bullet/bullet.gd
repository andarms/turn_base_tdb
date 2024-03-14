class_name Bullet extends Node2D

@export var speed = 100
@export var direction = Vector2(0, 0)

func _process(delta):
	var velocity = direction * speed * delta
	position += velocity
