extends Node


@export var initial_state : State
var current_state: State
var states : Dictionary = {}

@onready var idleST = $Idle
@onready var walkST = $Walk
@onready var runST = $Run
@onready var atackST = $Atack
@onready var get_damageST = $GetDamage
@onready var jumpST = $Jump
@onready var fallenST = $Fallen
@onready var rollST = $Roll


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		print("ALL SET ALMOST")
		initial_state.Enter()
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state: 
		current_state.Update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)


func on_child_transition(state, new_state_name):
	
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	print("CurrentState: "+str(new_state))
	
	current_state = new_state
	
	#if !new_state.Completed:
	#	on_child_transition(new_state, "idle")
	#	printerr("Corrupt: "+str(new_state)+"  | Falta una REFERENCIA")
	#	return
