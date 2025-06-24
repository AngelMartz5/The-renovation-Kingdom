extends Area2D
class_name AreaVision

@export var SeeingTarget : Array[Node2D] = []
@onready var atack_component = $"../../AtackComponent" as AttackComponent
@onready var information = $"../../Information"

var CambiosRequeridos : bool = false
#Aqui poner que haga la accion de atackar y que pueda detectar quien esta dentro de su area 
func _ready():
	body_entered.connect(_targetAppeard)
	body_exited.connect(_targetDesappeard)


func _targetAppeard(body:Node2D):
	if body == owner:
		return
	_searchTarget(body,)

func _targetDesappeard(body:Node2D):
	_searchTarget(body,false)

func _process(delta):
	if CambiosRequeridos:
		information.NearestPerson = get_closest_target()

func _searchTarget(targetToAdd : Node2D, agregar : bool = true):
	if agregar:
		
		if SeeingTarget.size() > 0:
			for target in SeeingTarget:
				if target == targetToAdd:
					return
			SeeingTarget.append(targetToAdd)
			information.NearestPerson = get_closest_target()
		else:
			information.NearestPerson = targetToAdd
			SeeingTarget.append(targetToAdd)
	else:
		if SeeingTarget.size() > 0:
			for target in SeeingTarget:
				if target == targetToAdd:
					SeeingTarget.erase(targetToAdd)
			information.NearestPerson = get_closest_target()
		
	if SeeingTarget.size() == 0:
		information.NearestPerson =null

# ✅ Devuelve el target más cercano al owner o null si no hay nadie
func get_closest_target() -> Node2D:
	CambiosRequeridos = false 
	if SeeingTarget.is_empty():
		return null

	var closest : Node2D = SeeingTarget[0]
	var min_distance : float = owner.global_position.distance_to(closest.global_position)

	for target in SeeingTarget:
		var distance = owner.global_position.distance_to(target.global_position)
		if distance < min_distance:
			min_distance = distance
			closest = target
	return closest
