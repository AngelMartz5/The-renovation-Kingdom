extends State
class_name Walk

signal WalkInit(WalkForce : float)


@export var OWNER : CharacterBody2D
@export var Movement : Node 

func Enter(): 
	OWNER.information.animation_component.SetAnimationPlayer(true)
	OWNER.information.animation_component.SetAnimationPlayer(false, true)
	

func Update(delta:float):
	if Movement.movement.x == 0:
		Transitioned.emit(self, "Idle")
	
	if Movement.Correr: 
		
		Transitioned.emit(self, "Run")
		
	
