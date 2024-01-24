class_name AttackAction extends Action

@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var body: CharacterBody2D

var done = false


func _ready() -> void:
	animation_player.animation_finished.connect(on_animation_finished)


func setup(_percents: Dictionary) -> void:
	animation_player.play(animation_name)
	done = false


func validate_execution() -> bool:
	return body.global_position.distance_to(WorldState.player_position) <= 16


func validate_preconditions(_agent_state: Dictionary) -> bool:
	return body.global_position.distance_to(WorldState.player_position) <= 16


func execute(_delta: float) -> Status:
	if done:
		return Status.Succeeded
	if body.global_position.distance_to(WorldState.player_position) >= 16:
		return Status.Failed
	return Status.Running


func cleanup() -> void:
	animation_player.stop()
	done = false


func on_animation_finished(_anim_name: String) -> void:
	done = true
