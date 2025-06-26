extends Node
class_name MovementAI

@onready var movement = $"../Movement"
@onready var information = $"../Information"

@export var controllPlayer : bool = false
var DirectionIaTGo: Vector2 = Vector2.ZERO
@export var DirectionIA : Vector2 = Vector2.ZERO

func _process(delta):
	if SignalBus.isallcompleted:
		if !information.isonAction and !information.needsAcomodation and !_necesitaPararseParaAtacar():
			if !controllPlayer:
				if movement.wallColliding:
					#DirectionIA.x *= -1
					pass
				
				DirectionIaTGo = DirectionIA
			else:
				
				var movx = int(Input.is_action_pressed("right"))- int(Input.is_action_pressed("left"))
				var movy : int = 0
				information.movement.butonRun = true if Input.is_action_pressed("Run") else false
				if !information.gravity.fly:
					information.gravity.buttonPressed = true if Input.is_action_just_pressed("jump") else false
				else:
					movy = int(Input.is_action_pressed("down"))- int(Input.is_action_pressed("up"))
				DirectionIaTGo = Vector2(movx,movy)
				
			if information.interact != null:
				if DirectionIaTGo != Vector2.ZERO:
					information.interact.CambiosRequeridos = true
			if information.area_vision != null:
				#NOSE CUANTO CONVENGA ESTO PORQUE CONSUME DEMASIADO
				information.area_vision.CambiosRequeridos = true
			movement._movimiento(DirectionIaTGo.x,DirectionIaTGo.y);
		

func _necesitaPararseParaAtacar()-> bool:
	var resultado : bool = false
	if information.seParaParaAtacar:
		if information.atacking:
			resultado = true
	return resultado
