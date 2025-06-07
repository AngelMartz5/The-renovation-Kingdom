extends Area2D

@export var grandparent : Player
@export var parent: Node2D
@onready var collision_shape_2d = $CollisionShape2D

var pressing : bool = false
var eletion : Button = null
@export var maxLenght : int = 900
@export var deadZone : int = 5
@onready var interact_component = $"../../InteractComponent" as INTERACT
@onready var information = $"../../Information" as INFORMATION

signal electedoption(eletionop : Button)


func area_entered(body:Node2D):
	_quitarselection()
	eletion = body.owner
	eletion.onTarget = true
	eletion.completedsignal.connect(_getsignalselection)


func _process(delta: float) -> void:
	if owner.information.isonAction:
		var direction = Input.get_vector("left", "right", "up", "down")
		collision_shape_2d.position = direction * 40


func _on_area_exited(area):
	_quitarselection()
	eletion = null

func _quitarselection():
	if eletion != null:
		eletion._cleanbars()
		eletion.completedsignal.disconnect(_getsignalselection)

func _getsignalselection(yourType:SignalBus.ACTIONBUTTONS):
	if yourType == SignalBus.ACTIONBUTTONS.EXIT:
		grandparent._changeControl(false)
	elif yourType == SignalBus.ACTIONBUTTONS.SPECIAL:
		interact_component._SpecialactionInteraction(information.Target)
