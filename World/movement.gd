extends Node

var wallColliding : bool = false

var movement : Vector2 = Vector2.ZERO
var Velocidad_Actual : float = 0
var butonRun : bool = false

var tweenSpeed : Tween 
var tweenDeseleracion : Tween 
var enTween : bool = false

var tweenSpeed2 : Tween 
var velocidadCorrecta : float = 0 
var VelocidadMaxima : float = 600
var enTween2 : bool = false

@export var OWNER : CharacterBody2D
@export var AnimacionSprite : AnimatedSprite2D
@export var NameState : String = "Walk"
@export var information : INFORMATION


@export_group("States")
@export var idle:Idle
@export var walk:Walk
@export var run:Run

var Correr : bool = false



func _ready():
	VelocidadMaxima = information.velocidad_inicial * 2
	Velocidad_Actual = information.velocidad_inicial
	tweenSpeed = create_tween()

func _process(delta):
	
	if butonRun and !wallColliding and movement.x != 0  and OWNER.is_on_floor():
		if movement.x < 0 and OWNER.velocity.x > 0 || movement.x > 0 and OWNER.velocity.x < 0:
			print("BUG")
			Correr = false
			_inicio_correr()
			enTween2 = false
		else:
			Correr = true
	else:
		Correr = false
		_inicio_correr()
		enTween2 = false
	
	if movement.x == 0:
		if enTween:
			tweenDeseleracion.stop()
			enTween = false
		information.animation_component.SetAnimationPlayer(true)
		walk.Transitioned.emit(self, "Idle")
	else:
		if OWNER.is_on_wall():
			wallColliding = true
		else:
			wallColliding = false
		_voltear(movement.x)
		


func _physics_process(delta):
	if !enTween and !enTween2:
		OWNER.velocity.x = movement.x * Velocidad_Actual 
	else:
		OWNER.velocity.x = velocidadCorrecta
	
	OWNER.move_and_slide()


func _movimiento(movx:float=0.0, movy:float=0.0):
	movement.x = movx
	movement.y = movy

func _enter_run():
	tweenSpeed2 = create_tween()
	if OWNER.is_on_floor():
		enTween2 = true
		tweenSpeed2.tween_method(_incremento_de_velocidad, OWNER.velocity.x, VelocidadMaxima*movement.x, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		
	

func _incremento_de_velocidad(velocidad : float):
	velocidadCorrecta = velocidad
	

func _inicio_correr():
	if OWNER.velocity.x > Velocidad_Actual || OWNER.velocity.x < -Velocidad_Actual: 
		enTween = true
		tweenDeseleracion = create_tween()
		tweenDeseleracion.tween_method(_decrecimiento_velocidad, OWNER.velocity.x, Velocidad_Actual* movement.x , 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
		tweenDeseleracion.tween_callback(func x(): enTween = false)
	

func _decrecimiento_velocidad(velocidad : float):
	velocidadCorrecta = velocidad
	

func _voltear(numero : int):
	if numero > 0 :
		information.visuals.scale.x = 1
	else:
		information.visuals.scale.x = -1
