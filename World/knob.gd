extends Area2D

@export var grandparent : Node2D
@export var parent: Node2D
@onready var collision_shape_2d = $CollisionShape2D

var pressing : bool = false
var eletion : Button = null
@export var maxLenght : int = 900
@export var deadZone : int = 5
@onready var control_buttons = $"../ControlButtons"

signal electedoption(eletionop : Button)


func area_entered(body:Node2D):
	_quitarselection()
	eletion = body.owner
	eletion.onTarget = true
	eletion.completedsignal.connect(_getsignalselection)


func _input(event):
	if SignalBus.isallcompleted and owner.myinteract != null:
		if owner.Myinformation.isonAction:
			var direction = Input.get_vector("left", "right", "up", "down")
			collision_shape_2d.position = direction * 40


func _on_area_exited(area):
	_quitarselection()

func _quitarselection():
	if eletion != null:
		eletion._cleanbars()
		eletion.completedsignal.disconnect(_getsignalselection)
		eletion = null

func _getsignalselection(yourType:SignalBus.ACTIONBUTTONS,butonSelected : Button):
	if yourType == SignalBus.ACTIONBUTTONS.EXIT:
		grandparent._changeControl(false)
	elif yourType == SignalBus.ACTIONBUTTONS.SPECIAL:  
		owner.myinteract_component._SpecialactionInteraction(butonSelected.accionButton["Name"])
	elif yourType == SignalBus.ACTIONBUTTONS.MORE:
		control_buttons._changeButtons(owner.myinteract_component.accionesDisponiblesOther)
