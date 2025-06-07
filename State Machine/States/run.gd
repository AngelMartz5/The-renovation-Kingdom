extends State
class_name Run

signal RunEnter()





@export var OWNER : CharacterBody2D
@export var Movement : Node 



func Enter():
	OWNER.information.animation_component.SetAnimationPlayer(false,false, true)
	Movement._enter_run();

func Update(delta:float):

	if Movement.movement.x == 0:
		Transitioned.emit(self, "Idle")
	if !Movement.Correr:
		Transitioned.emit(self, "Walk")

func Exit():
	Movement.tweenSpeed2.stop();
