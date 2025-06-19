extends Node
class_name MovementAI

@onready var movement = $"../Movement"
@onready var information = $"../Information"

@export var controllPlayer : bool = false
@export var DirectionIaTGo: Vector2 = Vector2.ZERO


func _process(delta):
	if SignalBus.isallcompleted:
		if !information.isonAction and !information.needsAcomodation and !_necesitaPararseParaAtacar():
			if !controllPlayer:
				if movement.wallColliding:
					DirectionIaTGo.x *= -1
				if DirectionIaTGo != Vector2.ZERO:
					information.interact.CambiosRequeridos = true
				movement._movimiento(DirectionIaTGo.x);
			else:
				
				var movx = int(Input.is_action_pressed("right"))- int(Input.is_action_pressed("left"))
				var movy : int = 0
				information.movement.butonRun = true if Input.is_action_pressed("Run") else false
				if !information.gravity.fly:
					information.gravity.buttonPressed = true if Input.is_action_just_pressed("jump") else false
				else:
					movy = int(Input.is_action_pressed("down"))- int(Input.is_action_pressed("up"))
				information.movement._movimiento(movx,movy);
				if movx != 0 or movy != 0:
					information.interact.CambiosRequeridos = true
		

func _necesitaPararseParaAtacar()-> bool:
	var resultado : bool = false
	if information.seParaParaAtacar:
		if information.atacking:
			resultado = true
	return resultado
