class_name SeekAction extends CompundAction

@export var body: CharacterBody2D

var neighbors: Array[Vector2] = [
	Vector2(0, 1),
	Vector2(1, 0),
	Vector2(0, -1),
	Vector2(-1, 0),
	Vector2(1, 1),
	Vector2(-1, 1),
	Vector2(1, -1),
	Vector2(-1, -1),
]


func decompose(_agent_state: Dictionary) -> Array[Action]:
	var m = MoveToTileAction.new()
	m.direction = seek()
	m.body = body
	return [m]


func seek():
	var weights = neighbors.map(func(n): return heuristic(n))
	weights.sort_custom(func(a, b): return a.weight < b.weight)
	var best = weights[0]
	return best.direction


func heuristic(direction: Vector2):
	var entity_pos = body.position + (direction * 16)
	var w = (
		abs(entity_pos.x - WorldState.player_position.x)
		+ abs(entity_pos.y - WorldState.player_position.y)
	)
	return {"weight": w, "direction": direction}
