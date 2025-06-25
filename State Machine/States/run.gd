extends State
class_name Run

signal RunEnter()





@export var OWNER : CharacterBody2D
@export var movement : Node 
@onready var animation_component: Node = $"../../AnimationComponent" as AnimationComponent
func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement


func Enter():
	information.animation_component.SetAnimationPlayer(AnimationTO)
	movement._enter_run();

func Update(delta:float):
	if information.jumped and state_machine.jumpST.exist:
		Transitioned.emit(self, "Jump")
	if state_machine.fallenST.exist:
		if information.isPlayerFallen :
			Transitioned.emit(self, "Fallen")
		if !information.isPlayerFallen:
			if information.stateAtack:
					if information.atack_component.attack() :
						print("ATACKED")
						Transitioned.emit(self, "Atack")
			if movement.movement.x == 0:
				Transitioned.emit(self, "Idle")
			if !movement.Correr:
				Transitioned.emit(self, "Walk")
			if information.gotDamage and state_machine.get_damageST.exist:
				Transitioned.emit(self, "GetDamage")
	else:
		if movement.movement.x == 0:
			Transitioned.emit(self, "Idle")
		if !movement.Correr:
			Transitioned.emit(self, "Walk")
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

func Exit():
	movement.tweenSpeed2.stop();
