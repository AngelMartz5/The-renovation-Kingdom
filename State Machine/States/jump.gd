extends State
class_name Jump

signal Jumping(WalkForce : float)

@export var OWNER : CharacterBody2D
@export var movement : Node 
@onready var animation_tree : AnimationTree = $"../../AnimationTree"

@onready var animation_component: Node = $"../../AnimationComponent" as AnimationComponent

signal AtackEnter()
func _ready():
	animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)
	await SignalBus.SetEverything
	var valueResult : bool = animation_component.GetAnimationPlayer(AnimationTO)
	exist = valueResult

func Enter():
	information.animation_component.SetAnimationPlayer(AnimationTO)
	print("-----------------------------------------------------------------------------------------------------ENTER JUMPING-----------------------------------------------------------------------------------------")

func _on_animation_tree_animation_finished(anim_name):
	information.jumped = false
	if state_machine.fallenST.exist:
		Transitioned.emit(self, "Fallen")
	else:
		Transitioned.emit(self, "Idle")
	
