extends State
class_name Atack
@onready var animation_tree : AnimationTree = $"../../AnimationTree"


signal AtackEnter()

func _ready():
	animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)
func Enter():
	information.animation_component.SetAnimationPlayer(AnimationTO)
	print("ATACK")
	if information.seParaParaAtacar:
		information.atacking = true
	
	_AniimationQuit()

func Update(_delta: float):
	if information.seParaParaAtacar:
		_inicioAnimation()

func Exit():
	information.stateAtack = false

func _AniimationQuit():
	var where = information.animation_component._getBeforeAnimation()
	if where == AnimationComponent.animationsInHasAnimations.idle:
		Transitioned.emit(self, "Idle")
	elif where == AnimationComponent.animationsInHasAnimations.walk:
		Transitioned.emit(self, "Walk")
	information.atacking = false 

func _inicioAnimation():
	information.movement._movimiento()


func _on_animation_tree_animation_finished(anim_name):
	_AniimationQuit()
	print("ME AYUDA: "+ anim_name)
	
