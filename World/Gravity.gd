extends Node2D
var Gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_VELOCITY = -500.0
var buttonPressed : bool = false

@onready var information = $"../Information" as INFORMATION
@onready var animation_component = $"../AnimationComponent" as AnimationComponent
@onready var atack_component = $"../AtackComponent" as AttackComponent
@onready var movement = $"../Movement"

@export var fly: bool = false

var Cayendo : bool = false : set = _cayendo
var fall_start_y : float = 0.0

signal Jumped()

func _physics_process(delta):
	if !fly:
		if owner.velocity.y > 0:
			Cayendo = true
		else:
			Cayendo = false

		if information.isPlayerFallen:
			owner.velocity.y += Gravity * delta

		if buttonPressed and information.canCharacterJump:
			information.jumped = true
			Jumped.emit()
			if !information.isPlayerFallen:
				owner.velocity.y = JUMP_VELOCITY
	else:
		owner.velocity.y = 0

	if !owner.is_on_floor():
		information.Flying.emit(true)
		information.isPlayerFallen = true
	else:
		information.Flying.emit(false)
		information.isPlayerFallen = false

	owner.move_and_slide()


func _cayendo(value: bool):
	if atack_component != null:
		# Empezó a caer
		if value and !Cayendo:
			fall_start_y = owner.global_position.y

		# Dejó de caer (aterrizó)
		elif !value and Cayendo:
			var fall_end_y = owner.global_position.y
			var fall_distance = fall_end_y - fall_start_y

			var threshold = 500.0  # No hay daño si cae desde menos que esto
			var damage = 0.0
			if fall_distance > threshold:
				damage = (fall_distance - threshold) * 0.1  # Escala de daño
				print("THE DAAMGED YOU GO FOR THE FALLING IS: "+str(damage))
				var attack_info = {
					"type": AreaAttack.AttackType.GRAVITY,
					"element": AreaAttack.ElementType.PHYSICAL,
					"damage": damage,
					"duration": 0.0,
					"tick_interval": 0.0,
				}

				atack_component.try_attack(owner, attack_info)

	Cayendo = value
