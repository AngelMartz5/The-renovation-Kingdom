extends Node2D

var Gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_VELOCITY = -400.0
@onready var idle = $"../State Machine/Idle"

func _ready():
	idle.IdleInit.connect(_desplazamiento)
	

func _desplazamiento():
	var tween = create_tween()
	if owner.is_on_floor():
		tween.tween_method(_detenimiento, owner.velocity.x, 0, 0.3)
	else:
		tween.tween_method(_detenimiento, owner.velocity.x, 0, 0.7)
		

func _detenimiento(Number : int ):
	owner.velocity.x = Number

func _physics_process(delta):
	if !owner.is_on_floor():
		owner.velocity.y += Gravity * delta
	if Input.is_action_just_pressed("ui_accept") and owner.is_on_floor():
		owner.velocity.y = JUMP_VELOCITY
	#print(owner.velocity)
	owner.move_and_slide()
