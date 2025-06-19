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
var fixTemporaly : Array[Vector2]

@export var OWNER : CharacterBody2D
@export var NameState : String = "Walk"
@export var information : INFORMATION


var Correr : bool = false
@export var isOnIdle : bool = true


func _ready():
	VelocidadMaxima = information.velocidad_inicial * 2
	Velocidad_Actual = information.velocidad_inicial
	tweenSpeed = create_tween()

func _process(delta):
	
	if butonRun and !wallColliding and movement.x != 0  and OWNER.is_on_floor():
		if movement.x < 0 and OWNER.velocity.x > 0 || movement.x > 0 and OWNER.velocity.x < 0:
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
	else:
		if OWNER.is_on_wall():
			wallColliding = true
		else:
			wallColliding = false
	_voltear(information.DirectionFace)
	
	
	


func _physics_process(delta):
	if !information.isonAction:
		if !enTween and !enTween2:
			OWNER.velocity.x = movement.x * Velocidad_Actual 
			if movement.y != 0.0:
				OWNER.velocity.y = movement.y * Velocidad_Actual 
		else:
			OWNER.velocity.x = velocidadCorrecta
		_convertidor(movement.x)
	else:
		if !information.needsAcomodation :
			movement = Vector2.ZERO
		else:
			OWNER.velocity.x = movement.x * Velocidad_Actual 
	
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
	

func _desplazamiento():
	var tween = create_tween()
	if owner.is_on_floor():
		tween.tween_method(_detenimiento, owner.velocity.x, 0, 0.3)
	else:
		tween.tween_method(_detenimiento, owner.velocity.x, 0, 0.7)
		

func _detenimiento(Number : int ):
	owner.velocity.x = Number

func _convertidor(numero : int):
	if numero > 0 :
		information.DirectionFace = true
	elif numero < 0:
		information.DirectionFace = false

func _voltear(bol : bool = false):
	if bol:
		information.visuals.scale.x = 1
		
	else:
		information.visuals.scale.x = -1
	

func _FromtoTo(from : Vector2, To : Vector2, me : Node2D) -> bool:
	var positionToGo = from.direction_to(To)
	var distancia = from.distance_to(To)

	# Agregado de control para cortar el bucle si está suficientemente cerca
	if distancia <= 1.0:
		_movimiento(0)
		print("¡Destino alcanzado!")
		return true

	# Movimiento según dirección X (puedes adaptarlo a 2D completo si quieres)
	if me.is_on_wall():
		print("COLISIONANDO")
		_movimiento(0)
		return true
	elif positionToGo.x > 0.2:
		_movimiento(0.2)
	elif positionToGo.x < -0.2:
		_movimiento(-0.2)
	else:
		_movimiento(0)
		return true

	print("%s  De Hacia:   %s" % [str(from), str(To)] + "  Ademas " + str(positionToGo)+ "  AUN HAY : " + str(distancia))
	return false


func isInInfinite(fix : Array[Vector2])-> bool:
	if fix.size() > 4:
		var i : int = 0
		var lastNumber : Vector2 = Vector2.ZERO
		for fixes in fix:
			if i >= 3:
				if (i % 2) == 0:
					pass
				else:
					pass
			i += 1
	return false
