extends State
class_name  Idle

signal IdleInit

@export var OWNER : CharacterBody2D
@export var movement : Node

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement

func Enter():
	IdleInit.emit()
	information.animation_component.SetAnimationPlayer(AnimationTO)
	information.movement.isOnIdle = true 

func Update(delta:float):
	if movement.movement.x != 0 and !movement.wallColliding:
		Transitioned.emit(self, "Walk")
	if information.stateAtack:
		if information.atack_component.attack():
			Transitioned.emit(self, "Atack")
	if information.gotDamage:
		Transitioned.emit(self, "GetDamage")

func Exit():
	information.movement.isOnIdle = false
