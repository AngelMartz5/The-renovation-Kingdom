extends  State
class_name GetDamage
@onready var animation_tree : AnimationTree = $"../../AnimationTree"
@onready var atack_component = $"../../AtackComponent"

signal AtackEnter()

func _ready():
	animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)
	

func Enter():
	information.animation_component.SetAnimationPlayer(AnimationTO)
	if atack_component.hasInmunity:
		atack_component.startInmunity()

func Exit():
	information.gotDamage = false

func _on_animation_tree_animation_finished(anim_name):
	Transitioned.emit(self, "Idle")
