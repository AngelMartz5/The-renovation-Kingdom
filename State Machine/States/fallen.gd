extends State
class_name Fallen

signal Falling(WalkForce : float)

@export var OWNER : CharacterBody2D
@export var movement : Node 

@onready var animation_component: Node = $"../../AnimationComponent" as AnimationComponent
@onready var animation_tree = $"../../AnimationTree"  as AnimationTree
func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement
	await SignalBus.SetEverything
	var valueResult : bool = animation_component.GetAnimationPlayer(AnimationTO)
	exist = valueResult

func Enter(): 
	print("_____________________________________OTHER                    FALLEN ______________________________________________")
	OWNER.information.animation_component.SetAnimationPlayer(AnimationTO)

func Update(delta:float):
	
	if !information.isPlayerFallen:
		if state_machine.rollST.exist or state_machine.rollST.existLand:
			print("ENTRO A ROLLLLLLLLLLLLLLLLLLLLLLLLEAR")
			Transitioned.emit(self, "Roll")
		else:
			Transitioned.emit(self, "Idle")
	if information.stateAtack:
			if state_machine.atackST.exist:
				if information.atack_component.attack():
					print("ATACKED")
					Transitioned.emit(self, "Atack")
