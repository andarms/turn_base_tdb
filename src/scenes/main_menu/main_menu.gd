class_name MainMenuScreen extends Control

@onready var version: Label = $MarginContainer/Version
@onready var new_game_button: Button = $MarginContainer/VBoxContainer/NewGameButton

func _ready() -> void:
	version.text = "Work in progress - Version: 0.0.1"
	new_game_button.grab_focus()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/play/play.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
