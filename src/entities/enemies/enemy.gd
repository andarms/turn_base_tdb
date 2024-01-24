class_name Enemy extends CharacterBody2D

@export var map: TileMap
@export var player: CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

var grid: AStarGrid2D
var is_moving: bool = false
var target_position: Vector2
var speed: float = 30
var path: Array[Vector2i] = []


func _ready() -> void:
	grid = AStarGrid2D.new()
	grid.region = map.get_used_rect()
	grid.cell_size = Vector2(16, 16)
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	grid.update()

	var region_size = grid.region.size
	var region_position = grid.region.position

	for x in range(region_size.x):
		for y in range(region_size.y):
			var tile_position = Vector2i(x + region_position.x, y + region_position.y)
			var tile_data = map.get_cell_tile_data(0, tile_position)

			if tile_data && !tile_data.get_custom_data("Walkable"):
				grid.set_point_solid(tile_position)


func _process(_delta: float) -> void:
	if is_moving:
		return
	move()


func _physics_process(delta: float) -> void:
	if !is_moving:
		return

	var distance: float = sprite.global_position.distance_to(target_position)
	if distance < 1:
		sprite.global_position = target_position
		is_moving = false
		return

	sprite.global_position = sprite.global_position.move_toward(target_position, speed * delta)


func move() -> void:
	var enemies_position = []
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy == self:
			continue
		var enemy_map_position = map.local_to_map(enemy.global_position)
		enemies_position.append(enemy_map_position)
		grid.set_point_solid(enemy_map_position)
		self.path = grid.get_id_path(
			map.local_to_map(global_position), map.local_to_map(player.global_position)
		)

	self.path.pop_front()
	if self.path.size() == 0:
		print("No path found")
		return

	if self.path.size() == 1:
		return

	var original_position = global_position
	target_position = map.map_to_local(self.path.front())
	global_position = target_position
	sprite.global_position = original_position
	is_moving = true

	for enemy_position in enemies_position:
		grid.set_point_solid(enemy_position, false)
