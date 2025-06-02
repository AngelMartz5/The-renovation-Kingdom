extends State
class_name  Idle

signal IdleInit

@export var OWNER : CharacterBody2D
@export var movement : Node

func Enter():
	IdleInit.emit()

func Update(delta:float):
	if movement.movement.x != 0:
		Transitioned.emit(self, "Walk")

func _on_animation_tree_animation_finished() -> void:
	
	OWNER.animation_component.SetAnimationPlayer(true)
