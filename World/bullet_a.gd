extends CharacterBody2D
@onready var information = $Information as INFORMATION
var haCollsionado : bool = false

func _ready():
	print("BULLETAPEARED")

func _physics_process(delta):
	if !haCollsionado:
		if self.is_on_floor() or information.movement.wallColliding: 
			print("COLISIONO CON UNA PARED XDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD")
			information.movimiento_ai_prueba.DirectionIA = Vector2.ZERO
			information.collision_shape_2d.disabled = true
			information.area_atack.monitoring = false
