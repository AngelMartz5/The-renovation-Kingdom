extends State
class_name Atack
@onready var animation_tree : AnimationTree = $"../../AnimationTree"
@onready var animation_component: Node = $"../../AnimationComponent" as AnimationComponent
var finalitation  :bool = false
signal AtackEnter()
@onready var movement =  $"../../Movement"

func _ready():
	animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)
	await SignalBus.SetEverything
	var valueResult : bool = animation_component.GetAnimationPlayer(AnimationComponent.animationsInHasAnimations.fallAtack)
	exist = valueResult

func Enter():
	finalitation = false
	information.animation_component.SetAnimationPlayer(AnimationTO)
	information.canCharacterJump = false
	print("ATACK")
	if information.seParaParaAtacar:
		information.atacking = true
	

func Update(_delta: float):
	if information.seParaParaAtacar:
		_inicioAnimation()
	if finalitation:
		if state_machine.fallenST.exist:
			if information.isPlayerFallen:
				Transitioned.emit(self, "Fallen")
			else:
				if movement.movement.x != 0 and !movement.wallColliding:
					Transitioned.emit(self, "Walk")
				else:
					Transitioned.emit(self, "Idle")
		else:
			if movement.movement.x != 0 and !movement.wallColliding:
				Transitioned.emit(self, "Walk")
			else:
				Transitioned.emit(self, "Idle")

func Exit():
	information.stateAtack = false
	information.canCharacterJump = true

func _inicioAnimation():
	information.movement._movimiento()


func _on_animation_tree_animation_finished(anim_name):
	information.gotDamage = false
	information.atacking = false 
	finalitation = true
	print("ME AYUDA: "+ anim_name)
	
