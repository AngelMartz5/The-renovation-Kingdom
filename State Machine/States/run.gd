extends State
class_name Run

signal RunEnter()





@export var OWNER : CharacterBody2D
@export var movement : Node 

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement


func Enter():
	information.animation_component.SetAnimationPlayer(AnimationTO)
	movement._enter_run();

func Update(delta:float):
	if movement.movement.x == 0:
		Transitioned.emit(self, "Idle")
	if !movement.Correr:
		Transitioned.emit(self, "Walk")
	if information.stateAtack:
		if information.atack_component.attack():
			Transitioned.emit(self, "Atack")
	if information.gotDamage:
		Transitioned.emit(self, "GetDamage")

func Exit():
	movement.tweenSpeed2.stop();
