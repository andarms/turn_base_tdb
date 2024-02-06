class_name StateMachine extends Node

var current_state : String='playermovementstate'
var states: Dictionary={}

func _ready():
	for state in get_children():
		if state is State:
			states[state.name.to_lower()]=state
			state.transitioned.connect(set_state)
		else:
			print("Error: StateMachine can only have State children")


func _process(delta):
	if current_state!="":
		states[current_state].process(delta)
	

func _physics_process(delta):
	if current_state!="":
		states[current_state].physics_process(delta)


func set_state(state_name : String):
	if states.has(state_name):
		if current_state!="":
			states[current_state].exit()
		current_state=state_name
		states[current_state].enter()
	else:
		print("Error: StateMachine has no state named "+state_name)

func get_state():
	return current_state
