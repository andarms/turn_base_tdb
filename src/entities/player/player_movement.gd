class_name PlayerMovement extends Node2D

@export var map: TileMap
@export var speed: float = 60
@export var body: CharacterBody2D
@export var ray: RayCast2D

var is_moving = false
var target_position: Vector2


func _process(_delta: float) -> void:
	if is_moving:
		return

	if Input.is_action_pressed("up"):
		move(Vector2(0, -1))
	elif Input.is_action_pressed("down"):
		move(Vector2(0, 1))
	elif Input.is_action_pressed("left"):
		move(Vector2(-1, 0))
	elif Input.is_action_pressed("right"):
		move(Vector2(1, 0))


func _physics_process(delta: float) -> void:
	if !is_moving:
		return

	var distance: float = body.global_position.distance_to(target_position)
	if distance < 1:
		body.global_position = target_position
		is_moving = false
		return

	body.global_position = body.global_position.move_toward(target_position, speed * delta)


func move(direction: Vector2) -> void:
	var current_tile: Vector2i = map.local_to_map(body.global_position)
	var target_tile: Vector2i = Vector2i(current_tile.x + direction.x, current_tile.y + direction.y)
	var tile_data: TileData = map.get_cell_tile_data(0, target_tile)

	if tile_data.get_custom_data("Walkable") == false:
		return

	ray.target_position = direction * 16
	ray.force_raycast_update()

	if ray.is_colliding():
		return

	target_position = map.map_to_local(target_tile)
	is_moving = true
