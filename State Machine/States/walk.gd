extends State
class_name Walk

signal WalkInit(WalkForce : float)

@export var OWNER : CharacterBody2D
@export var movement : Node 
@onready var animation_component: Node = $"../../AnimationComponent" as AnimationComponent
func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement
	print("JUMPED")

func Enter(): 
	await animation_component.onAnimation == false
	OWNER.information.animation_component.SetAnimationPlayer(AnimationTO)
	

func Update(delta:float):
	if information.jumped and state_machine.jumpST.exist:
		Transitioned.emit(self, "Jump")
	if  state_machine.fallenST.exist:
		if information.isPlayerFallen:
			Transitioned.emit(self, "Fallen")
		if !information.isPlayerFallen:
			if information.stateAtack:
				if information.atack_component.attack() :
					print("ATACKED")
					Transitioned.emit(self, "Atack")
			if movement.movement.x == 0 || movement.wallColliding:
				Transitioned.emit(self, "Idle")
			if movement.Correr: 
				Transitioned.emit(self, "Run")
				
			if information.gotDamage and state_machine.get_damageST.exist:
				Transitioned.emit(self, "GetDamage")
	else:
		if movement.movement.x == 0 || movement.wallColliding:
				Transitioned.emit(self, "Idle")
		if !information.isPlayerFallen:
			if information.stateAtack:
				if information.atack_component.attack() :
					print("ATACKED")
					Transitioned.emit(self, "Atack")
			if information.gotDamage and state_machine.get_damageST.exist:
				Transitioned.emit(self, "GetDamage")
		else:
			if information.stateAtack:
				if state_machine.atackST.exist:
					if information.atack_component.attack():
						print("ATACKED")
						Transitioned.emit(self, "Atack")
		if movement.Correr: 
				Transitioned.emit(self, "Run")
