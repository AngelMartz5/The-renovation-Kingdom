extends Node
class_name INTERACT

@onready var information = $"../Information" as INFORMATION
@onready var interact = $"../Interact"  as InteractZone

var somebodyAvalible : bool = false

func _ready():
	interact.somebodyentered.connect(_bodyentered)

func _bodyentered(body:Node2D):
	if body != null:
		somebodyAvalible = true
	else:
		somebodyAvalible = false

func _stopEverything(other : Node2D = null, onaction : bool = false):
	information.isonAction = onaction 
	if other != null:
		other.information.isonAction = onaction 

func _setTarget():
	information.Target = interact.bodyinteract

func _SpecialactionInteraction(other : Node2D):
	var resultado = information.mytype.ejecutar_accion(self.owner, information.Target, "Alimentar")
	print(resultado["mensaje"])
