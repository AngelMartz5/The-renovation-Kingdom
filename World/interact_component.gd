extends Node
class_name INTERACT

@onready var information = $"../Information" as INFORMATION
@onready var interact = $"../Interact"  as InteractZone

var somebodyAvalible : bool = false
var accionesDisponiblesOther = []
signal setTarget()

func _ready():
	interact.somebodyentered.connect(_bodyentered)

func _bodyentered(body:Node2D):
	if body != null:
		somebodyAvalible = true
		_setTarget()
		
	else:
		somebodyAvalible = false

func _stopEverything(other : Node2D = null, onaction : bool = false):
	information.isonAction = onaction 
	if other != null:
		other.information.isonAction = onaction 

func _setTarget():
	information.Target = interact.bodyinteract
	_getAccionesDisponibles()
	setTarget.emit()

func _SpecialactionInteraction(Action : String,other : Node2D = information.Target):
	var resultado = information.mytype.ejecutar_accion(self.owner, other, Action)
	print(resultado["mensaje"])

func _getAccionesDisponibles():
	var other = information.Target.information.mytype
	accionesDisponiblesOther = other.get_acciones_validas_para_tipos(other.tipos, self.information.mytype.tipos)
	#for i in accionesDisponiblesOther.size():
	#	print(accionesDisponiblesOther[i]["Name"])
