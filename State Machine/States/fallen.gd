extends State
class_name Fallen

signal Falling(WalkForce : float)

@export var OWNER : CharacterBody2D
@export var movement : Node 

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement

func Enter(): 
	print("OWNER: "+ str(OWNER))
	OWNER.information.animation_component.SetAnimationPlayer(AnimationTO)
	print("Salté")

func Update(delta:float):
	if !information.isPlayerFallen:
		Transitioned.emit(self, "Idle")

func Exit():
	if !OWNER.information.animation_component.SetAnimationPlayer(AnimationComponent.animationsInHasAnimations.roll):
		OWNER.information.animation_component.SetAnimationPlayer(AnimationComponent.animationsInHasAnimations.land)
	
