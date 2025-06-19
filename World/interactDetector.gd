extends Area2D
class_name InteractZone

@onready var interact_component = $"../InteractComponent" as INTERACT
@onready var information = $"../Information"

@export var bodyinteract : Node2D = null
@export var BodiesEntered : Array[Node2D] = []
var CambiosRequeridos : bool = false
signal somebodyentered(body:Node2D)
signal somebodyExited(body:Node2D)

func _ready() -> void:
	body_entered.connect(Item_entered)
	body_exited.connect(Item_exited)

func Item_entered(body:Node2D):
	if body.information.mytype != null and body != owner:
		_searchTarget(body)
		CambiosRequeridos = true
	

func Item_exited(body:Node2D):
	if body.information.mytype != null:
		_searchTarget(body,false)
		CambiosRequeridos = true
		somebodyExited.emit(body)

func _process(delta):
	if CambiosRequeridos:
		print("CHANGES")
		bodyinteract = get_closest_target()
		somebodyentered.emit(bodyinteract)

func _searchTarget(targetToAdd : Node2D, agregar : bool = true):
	var bodyinteract2 = null
	if agregar:
		
		if BodiesEntered.size() > 0:
			for target in BodiesEntered:
				if target == targetToAdd:
					return
			BodiesEntered.append(targetToAdd)
		else:
			BodiesEntered.append(targetToAdd)
	else:
		if BodiesEntered.size() > 0:
			for target in BodiesEntered:
				if target == targetToAdd:
					BodiesEntered.erase(targetToAdd)
	
	

# ✅ Devuelve el target más cercano al owner o null si no hay nadie
func get_closest_target() -> Node2D:
	CambiosRequeridos = false 
	if BodiesEntered.is_empty():
		return null

	var closest : Node2D = BodiesEntered[0]
	var min_distance : float = owner.global_position.distance_to(closest.global_position)

	for target in BodiesEntered:
		var distance = owner.global_position.distance_to(target.global_position)
		if distance < min_distance:
			min_distance = distance
			closest = target
	return closest
