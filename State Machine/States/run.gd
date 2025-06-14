extends State
class_name Run

signal RunEnter()


@onready var information = $"../../Information"


@export var OWNER : CharacterBody2D
@export var movement : Node 

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement


func Enter():
	OWNER.information.animation_component.SetAnimationPlayer(false,false, true)
	movement._enter_run();

func Update(delta:float):

	if movement.movement.x == 0:
		Transitioned.emit(self, "Idle")
	if !movement.Correr:
		Transitioned.emit(self, "Walk")

func Exit():
	movement.tweenSpeed2.stop();
