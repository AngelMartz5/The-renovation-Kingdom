extends CharacterBody2D
class_name Player

var horseavaliable : bool = false
@onready var information = $Information
@onready var text_actions = $TextActions
@onready var controller = $Controller
@onready var interactavailable = $Interact


func _ready():
	_interactAvailable(false)
	interactavailable.interactavailable.connect(_interactAvailable)
	_changeControl(false)
	

func _input(event):
	if event.is_action_pressed("Action") and horseavaliable:
		_changeControl(true)

func _process(delta):
	if !information.isonAction:
		var mov = int(Input.is_action_pressed("right"))- int(Input.is_action_pressed("left"))
		information.movement._movimiento(mov);
		information.movement.butonRun = true if Input.is_action_pressed("Run") else false
	
	

func _interactAvailable(enter:bool):
	text_actions.visible = enter
	horseavaliable = enter

func _changeControl(bol:bool):
	information.isonAction = bol
	controller.visible = bol
