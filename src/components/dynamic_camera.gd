class_name DynamicCamera extends Camera2D

const MAX_DISTANCE = 48

var target_distance = 0
var center_position = position

func _process(delta):
	var diretion = center_position.direction_to(get_local_mouse_position())
	var target_position = center_position + diretion * target_distance
	position = target_position.clamp(
		center_position - Vector2(MAX_DISTANCE, MAX_DISTANCE),
		center_position + Vector2(MAX_DISTANCE, MAX_DISTANCE)
		)

func _input(event):
	if event is InputEventMouseMotion:
		target_distance = center_position.distance_to(get_local_mouse_position()) / 2
