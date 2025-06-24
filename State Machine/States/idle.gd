extends State
class_name  Idle

signal IdleInit

@export var OWNER : CharacterBody2D
@export var movement : Node
@onready var animation_component: Node = $"../../AnimationComponent" as AnimationComponent
@onready var animation_tree = $"../../AnimationTree"  as AnimationTree
@onready var jumpSt = $"../Jump"

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement
	if animation_component == null:
		information.animation_component

func Enter():
	IdleInit.emit()
	information.canCharacterJump = true
	animation_component.SetAnimationPlayer(AnimationTO)
	movement.isOnIdle = true 
	if !information.gravity.fly:
		movement._desplazamiento()


func Update(delta:float):
	if information.stateAtack:
		if information.atack_component.attack() :
			print("ATACKED")
			Transitioned.emit(self, "Atack")
	if information.jumped and jumpSt.exist:
		Transitioned.emit(self, "Jump")
	if state_machine.fallenST.exist:
		if information.isPlayerFallen:
			Transitioned.emit(self, "Fallen")
		if !information.isPlayerFallen:
			if movement.movement.x != 0 and !movement.wallColliding:
				Transitioned.emit(self, "Walk")
			if information.gotDamage:
				var Helper: bool = state_machine.get_damageST.exist
				if Helper:
					Transitioned.emit(self, "GetDamage")
	else:
		if movement.movement.x != 0 and !movement.wallColliding:
				Transitioned.emit(self, "Walk")
		if !information.isPlayerFallen:
			if information.gotDamage:
					var Helper: bool = state_machine.get_damageST.exist
					if Helper:
						Transitioned.emit(self, "GetDamage")

func Exit():
	movement.isOnIdle = false
