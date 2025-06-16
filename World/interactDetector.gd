extends Area2D
class_name InteractZone

@onready var interact_component = $"../InteractComponent" as INTERACT
@onready var information = $"../Information"

var bodyinteract : Node2D = null

signal somebodyentered(body:Node2D)
signal somebodyExited(body:Node2D)

func _ready() -> void:
	body_entered.connect(Item_entered)
	body_exited.connect(Item_exited)

func Item_entered(body:Node2D):
	if body.information.mytype != null:
		bodyinteract = body
		somebodyentered.emit(bodyinteract)
	

func Item_exited(body:Node2D):
	if body.information.mytype != null:
		bodyinteract = null
		somebodyentered.emit(bodyinteract)
		somebodyExited.emit(body)
