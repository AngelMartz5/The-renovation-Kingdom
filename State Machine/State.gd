extends Node


class_name State

@export var AnimationTO : AnimationComponent.animationsInHasAnimations
@onready var information = $"../../Information" as INFORMATION
signal Transitioned
@onready var state_machine = $".." 

var Completed : bool = true
@export var exist : bool = false


func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
