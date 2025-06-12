extends Node
class_name MovementAI

@onready var movement = $"../Movement"
@onready var information = $"../Information"

var controllPlayer : bool = false
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
				var mov = int(Input.is_action_pressed("right"))- int(Input.is_action_pressed("left"))
				information.movement._movimiento(mov);
				information.movement.butonRun = true if Input.is_action_pressed("Run") else false
				information.gravity.buttonPressed = true if Input.is_action_just_pressed("jump") else false
		
