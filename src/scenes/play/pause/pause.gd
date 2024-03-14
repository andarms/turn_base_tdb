class_name PauseLayer extends Control

@onready var continue_button: Button = $MarginContainer/VBoxContainer/Continue

func _ready():
	visible = false
	continue_button.grab_focus()

func _on_main_menu_button_pressed():
	AssetsReferences.paused = false
	AssetsReferences.back_to_main_menu()

func _on_continue_pressed() -> void:
	AssetsReferences.paused = false
	visible = false

func toggle():
	AssetsReferences.paused = !AssetsReferences.paused
	visible = AssetsReferences.paused
	if AssetsReferences.paused:
		continue_button.grab_focus()
		get_tree().paused = true
