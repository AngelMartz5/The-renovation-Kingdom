extends Node2D

var Gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_VELOCITY = -400.0
var buttonPressed : bool = false
@onready var information = $"../Information" as INFORMATION
@onready var animation_component = $"../AnimationComponent" as AnimationComponent
@export var AnimationTO : AnimationComponent.animationsInHasAnimations
@export var fly: bool = false



func _physics_process(delta):
	if !fly:
		if information.isPlayerFallen:
			owner.velocity.y += Gravity * delta
		if buttonPressed and !information.isPlayerFallen:
			animation_component.SetAnimationPlayer(AnimationTO)
			owner.velocity.y = JUMP_VELOCITY
	else:
		owner.velocity.y = 0
	if !owner.is_on_floor() :
		information.isPlayerFallen = true
	else:
		information.isPlayerFallen = false
	owner.move_and_slide()
