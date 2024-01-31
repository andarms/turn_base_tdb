extends Node

signal next_turn
var current_turn = 0
var turn_timer = Timer.new()


func _ready() -> void:
	next_turn.connect(_on_next_turn)
	add_child(turn_timer)
	turn_timer.set_wait_time(0.5)
	turn_timer.timeout.connect(emit_next_turn)


func _on_next_turn() -> void:
	current_turn += 1


func emit_next_turn() -> void:
	next_turn.emit()


func force_next_turn() -> void:
	turn_timer.stop()
	turn_timer.start()
	emit_next_turn()
