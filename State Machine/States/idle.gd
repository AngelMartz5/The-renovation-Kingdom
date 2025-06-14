extends State
class_name  Idle

signal IdleInit

@export var OWNER : CharacterBody2D
@export var movement : Node
@onready var information = $"../../Information"

func _ready():
	if OWNER == null:
		OWNER = owner.owner
	if movement == null:
		movement = information.movement

func Enter():
	IdleInit.emit()
	information.animation_component.SetAnimationPlayer()

func Update(delta:float):
	if movement.movement.x != 0 and !movement.wallColliding:
		Transitioned.emit(self, "Walk")
