extends CharacterBody2D
class_name Player

@onready var information = $Information
@onready var text_actions = $TextActions
@onready var controller = $Controller
@onready var interactavailable = $Interact as InteractZone
@onready var interact_camera_2d = $InteractCamera2D
@onready var interact_component = $InteractComponent as INTERACT
@onready var nameLabel = $Controller/NAME


func _ready():
	_somebodyentered()
	interactavailable.somebodyentered.connect(_somebodyentered)
	_changeControl(false)

func _input(event):
	if event.is_action_pressed("Action") and interact_component.somebodyAvalible:
		interact_component._setTarget()
		_changeControl(true)
		

func _process(delta):
	if SignalBus.isallcompleted:
		if !information.isonAction:
			var mov = int(Input.is_action_pressed("right"))- int(Input.is_action_pressed("left"))
			information.movement._movimiento(mov);
			information.movement.butonRun = true if Input.is_action_pressed("Run") else false
			information.gravity.buttonPressed = true if Input.is_action_just_pressed("jump") else false
	
	

func _somebodyentered(body:Node2D = null):
	var helpbool : bool = interact_component.somebodyAvalible
	_showTxtButtons(helpbool)
	if helpbool:
		interact_camera_2d.set_priority(11)
	else:
		interact_camera_2d.set_priority(0)

func _changeControl(bol:bool):
	var target = information.Target
	controller.visible = bol
	_showTxtButtons( false)
	if target != null:
		nameLabel.text = target.information.NAME
		interact_component._stopEverything(target,bol)
		if bol == true:
			var me : Node2D = self
			target.information.acomodation_component._setAcomodation(me, target, 100)
		else :
			target.information.acomodation_component._quitAcomodation()
	else:
		interact_component._stopEverything(null, bol)
	
	

func _showTxtButtons(bol : bool = false):
	text_actions.visible = bol
