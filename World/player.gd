extends CharacterBody2D
class_name Player

var horseavaliable : bool = false
@onready var information = $Information
@onready var text_actions = $TextActions
@onready var montar = $Montar

func _ready():
	_montarAvailable(false)
	montar.animalavailable.connect(_montarAvailable)
	

func _input(event):
	if event.is_action_pressed("Actionride") and horseavaliable:
		print("SE SUBIOOOOOOOOOOOO")

func _process(delta):
	var mov = int(Input.is_action_pressed("right"))- int(Input.is_action_pressed("left"))
	information.movement._movimiento(mov);
	
	information.movement.butonRun = true if Input.is_action_pressed("Run") else false
	
	

func _montarAvailable(enter:bool):
	text_actions.visible = enter
	horseavaliable = enter
