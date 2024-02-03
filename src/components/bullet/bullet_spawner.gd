class_name BulletSpawner extends Node2D

@export var bullet: PackedScene
@export var bullet_direction: Vector2
@export_range(0.1, 2) var cooldown: float = 1

var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.set_wait_time(cooldown)
	timer.set_one_shot(true)
	timer.timeout.connect(spawn_bullet)
	add_child(timer)
	timer.start()


func spawn_bullet() -> void:
	var direction =  WorldState.player_position -global_position
	var bullet_instance: Bullet = bullet.instantiate()
	bullet_instance.direction = direction.normalized()
	bullet_instance.position = position
	add_child(bullet_instance)
	timer.start()

