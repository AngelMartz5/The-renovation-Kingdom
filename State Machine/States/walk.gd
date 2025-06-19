extends State
class_name Walk

signal WalkInit(WalkForce : float)

@export var OWNER : CharacterBody2D
@export var movement : Node 

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement

func Enter(): 
	OWNER.information.animation_component.SetAnimationPlayer(AnimationTO)
	

func Update(delta:float):
	if information.stateAtack:
		if information.atack_component.attack():
			Transitioned.emit(self, "Atack")
	if movement.movement.x == 0 || movement.wallColliding:
		Transitioned.emit(self, "Idle")
	if movement.Correr: 
		
		Transitioned.emit(self, "Run")
		
	if information.gotDamage:
		Transitioned.emit(self, "GetDamage")
