class_name MainMenuScreen extends Control

@onready var version: Label = $MarginContainer/Version


func _ready() -> void:
	version.text = "Work in progress - Version: 0.0.1"


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://src/screens/play/play.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
