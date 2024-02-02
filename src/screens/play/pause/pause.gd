class_name PauseSubScreen extends Control


func _on_main_menu_button_pressed():
	AssetsReferences.paused = false
	AssetsReferences.back_to_main_menu()


func _on_continue_pressed() -> void:
	AssetsReferences.paused = false
	visible = false


func toggle():
	AssetsReferences.paused = !AssetsReferences.paused
	visible = AssetsReferences.paused
