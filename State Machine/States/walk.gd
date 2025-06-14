extends State
class_name Walk

signal WalkInit(WalkForce : float)

@onready var information = $"../../Information"

@export var OWNER : CharacterBody2D
@export var movement : Node 

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement

func Enter(): 
	OWNER.information.animation_component.SetAnimationPlayer(true)
	OWNER.information.animation_component.SetAnimationPlayer(false, true)
	

func Update(delta:float):
	if movement.movement.x == 0 || movement.wallColliding:
		Transitioned.emit(self, "Idle")
	
	if movement.Correr: 
		
		Transitioned.emit(self, "Run")
		
	
