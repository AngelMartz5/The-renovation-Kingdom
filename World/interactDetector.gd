extends Area2D
@export var OWNER:CharacterBody2D

@onready var item_camera_2d: PhantomCamera2D = $PhantomCamera2D

signal interactavailable(enter:bool)
func _ready() -> void:
	body_entered.connect(Item_entered)
	body_exited.connect(Item_exited)

func Item_entered(body:Node2D):
	
	item_camera_2d.set_priority(11)
	if body is Interactuable:
		interactavailable.emit(true)
	

func Item_exited(body:Node2D):
	
	item_camera_2d.set_priority(0)
	if body is Interactuable:
		interactavailable.emit(false)
