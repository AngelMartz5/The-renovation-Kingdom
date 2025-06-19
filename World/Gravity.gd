extends Node2D

var Gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_VELOCITY = -400.0
var buttonPressed : bool = false

@export var fly: bool = false



func _physics_process(delta):
	if !fly:
		if !owner.is_on_floor():
			owner.velocity.y += Gravity * delta
		if buttonPressed and owner.is_on_floor():
			owner.velocity.y = JUMP_VELOCITY
	else:
		owner.velocity.y = 0
	owner.move_and_slide()
