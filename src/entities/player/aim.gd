class_name  AimState extends State


@export var cursor: Node2D
@export var body : CharacterBody2D



func process(_d):
	if Input.is_action_just_released("aim"):
		transitioned.emit('playermovementstate')
		return
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var x = 1 if input_direction.x > 0.65 else -1 if input_direction.x < 0 else 0
	var y = 1 if input_direction.y > 0.65 else -1 if input_direction.y < 0 else 0
	if x != 0 or y != 0:
		cursor.global_position = body.global_position + Vector2(x, y) * 16
