class_name PlayerMovementState extends State

@export var map: TileMap
@export var speed: float = 100
@export var body: CharacterBody2D
@export var ray: RayCast2D
@export var cursor: Node2D

var is_moving = false
var target_position: Vector2
var direction: Vector2

func process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		direction = direction.normalized()

func physics_process(delta: float) -> void:
	if AssetsReferences.paused:
		return
	body.position += direction * speed * delta
