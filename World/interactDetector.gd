extends Area2D
class_name InteractZone

@onready var interact_component = $"../InteractComponent" as INTERACT

var bodyinteract : Node2D = null

signal somebodyentered(body:Node2D)

func _ready() -> void:
	body_entered.connect(Item_entered)
	body_exited.connect(Item_exited)

func Item_entered(body:Node2D):
	
	if body is Interactuable:
		bodyinteract = body
		somebodyentered.emit(bodyinteract)
	

func Item_exited(body:Node2D):
	if body is Interactuable:
		bodyinteract = null
		somebodyentered.emit(bodyinteract)
