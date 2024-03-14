class_name PlayeScreen extends Node2D

@onready var pause_scene: PauseLayer = $CanvasLayer/Pause

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause_scene.toggle()
