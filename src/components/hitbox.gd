class_name HitBox extends Area2D

signal hit(area: Area2D)

@export var damage: Damage


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		var result = damage.calcaulate_damage()
		if damage.is_critical(result[1]):
			print("Critical Hit!")
		area.take_damage(result[0])
		AssetsReferences.create_damage_indicator(area.position, result[0])
		hit.emit(area)
