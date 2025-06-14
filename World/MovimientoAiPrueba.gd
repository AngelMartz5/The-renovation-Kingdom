extends Node
class_name MovementAI

@onready var movement = $"../Movement"
@onready var information = $"../Information"

@export var controllPlayer : bool = false
var movedir = 1;


func _process(delta):
	if SignalBus.isallcompleted:
		if !controllPlayer:
			if !information.isonAction and !information.acomodation_component.needsAcomodation:
				if movement.wallColliding:
					movedir = -1
				movement._movimiento(movedir);
		else:
			if !information.isonAction and !information.acomodation_component.needsAcomodation:
				var movx = int(Input.is_action_pressed("right"))- int(Input.is_action_pressed("left"))
				var movy : int = 0
				information.movement.butonRun = true if Input.is_action_pressed("Run") else false
				if !information.gravity.fly:
					information.gravity.buttonPressed = true if Input.is_action_just_pressed("jump") else false
				else:
					movy = int(Input.is_action_pressed("down"))- int(Input.is_action_pressed("up"))
				information.movement._movimiento(movx,movy);
		
