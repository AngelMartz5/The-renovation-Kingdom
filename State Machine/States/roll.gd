extends State
class_name Roll

signal Falling(WalkForce : float)

@export var OWNER : CharacterBody2D
@export var movement : Node 
var finalitation  :bool = false
@onready var animation_component: Node = $"../../AnimationComponent" as AnimationComponent
@onready var animation_tree = $"../../AnimationTree"  as AnimationTree

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement
	animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)
	await SignalBus.SetEverything 
	var valueResult : bool = animation_component.GetAnimationPlayer(AnimationTO)
	exist = valueResult

func Enter(): 
	information.canCharacterJump = false
	finalitation = false
	var where = information.animation_component.beforeAnimation
	if where == AnimationComponent.animationsInHasAnimations.fallen:
		if movement.movement.x != 0:
			OWNER.information.animation_component.SetAnimationPlayer(AnimationTO)
		else:
			var AnimationTo2 = AnimationComponent.animationsInHasAnimations.land
			animation_component.SetAnimationPlayer(AnimationTo2)
	else:
		OWNER.information.animation_component.SetAnimationPlayer(AnimationTO)

func Update(delta:float):
	if finalitation:
		print("DEBERIA SALIR")
		Transitioned.emit(self, "Idle")


func _on_animation_tree_animation_finished(anim_name):
	print("ANIMATION NAME: "+str(anim_name))
	finalitation = true
