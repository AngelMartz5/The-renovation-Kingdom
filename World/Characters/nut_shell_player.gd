extends Node2D

@export var ActualPlayer : Node2D 
@export var Myinformation : INFORMATION
@export var myinteract : InteractZone
@export var myinteract_component : INTERACT

@onready var text_actions = $TextActions
@onready var controller = $Controller
@onready var interact_camera_2d = $InteractCamera2D
@onready var nameLabel = $Controller/NAME
@onready var control_buttons = $Controller/ControlButtons
@onready var phantom_camera_2d = $"../PhantomCamera2D"



func _ready():
	SignalBus.isCompleted.connect(needesAfterReady)
	

func needesAfterReady():
	Myinformation = ActualPlayer.information
	myinteract = Myinformation.interact
	myinteract_component = Myinformation.interact_component
	interact_camera_2d.follow_target = ActualPlayer
	phantom_camera_2d.follow_target = ActualPlayer
	Myinformation.movimiento_ai_prueba.controllPlayer = true
	_somebodyentered()
	myinteract.somebodyentered.connect(_somebodyentered)
	myinteract_component.setTarget.connect(control_buttons._aftersetTarget)
	_changeControl(false)


func _input(event):
	if SignalBus.isallcompleted:
		if event.is_action_pressed("Action") and Myinformation.interact_component.somebodyAvalible:
			Myinformation.interact_component._setTarget()
			_changeControl(true)
		
		if event.is_action_type():
			controller.position = ActualPlayer.global_position
			text_actions.position = ActualPlayer.global_position
	



func _somebodyentered(body:Node2D = null):
	var helpbool : bool = Myinformation.interact_component.somebodyAvalible
	_showTxtButtons(helpbool)
	if helpbool:
		interact_camera_2d.set_priority(11)
	else:
		interact_camera_2d.set_priority(0)

func _changeControl(bol:bool):
	var target = Myinformation.Target
	controller.visible = bol
	_showTxtButtons( false)
	if target != null:
		nameLabel.text = target.information.NAME
		Myinformation.interact_component._stopEverything(target,bol)
		if bol == true:
			var me : Node2D = ActualPlayer
			target.information.acomodation_component._setAcomodation(me, target, 100)
		else :
			target.information.acomodation_component._quitAcomodation()
	else:
		Myinformation.interact_component._stopEverything(null, bol)
	
	

func _showTxtButtons(bol : bool = false):
	text_actions.visible = bol
