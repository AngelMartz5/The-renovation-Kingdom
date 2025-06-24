extends  State
class_name GetDamage
@onready var animation_tree : AnimationTree = $"../../AnimationTree"
@onready var atack_component = $"../../AtackComponent"
@onready var animation_component: Node = $"../../AnimationComponent" as AnimationComponent
var finalitation  :bool = false
signal AtackEnter()

func _ready():
	animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)
	await SignalBus.SetEverything
	var valueResult : bool = animation_component.GetAnimationPlayer(AnimationTO)
	exist = valueResult

func Enter():
	finalitation = false
	print("GOT DAMAGED")
	information.animation_component.SetAnimationPlayer(AnimationTO)
	if atack_component.hasInmunity:
		atack_component.startInmunity()

func Update(delta:float):
	if finalitation:
		if information.isPlayerFallen and state_machine.fallenST.exist:
			Transitioned.emit(self, "Fallen")
		else:
			Transitioned.emit(self, "Idle")

func Exit():
	information.stateAtack = false
	information.gotDamage = false

func _on_animation_tree_animation_finished(anim_name):
	print("ME AYUDA2: "+ anim_name)
	finalitation = true
