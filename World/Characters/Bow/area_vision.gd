extends Area2D
class_name AreaVision

@export var SeeingTarget : Array[Node2D] = []
@onready var atack_component = $"../../AtackComponent" as AttackComponent

#Aqui poner que haga la accion de atackar y que pueda detectar quien esta dentro de su area 
func _ready():
	body_entered.connect(_targetAppeard)
	body_exited.connect(_targetDesappeard)


func _targetAppeard(body:Node2D):
	if body == owner:
		return
	print("ENTRO:  " + str(body))
	_searchTarget(body,)

func _targetDesappeard(body:Node2D):
	_searchTarget(body,false)

func _searchTarget(targetToAdd : Node2D, agregar : bool = true):
	if agregar:
		
		if SeeingTarget.size() > 0:
			for target in SeeingTarget:
				if target == targetToAdd:
					return
			SeeingTarget.append(targetToAdd)
			atack_component.NearestPerson = get_closest_target()
		else:
			atack_component.NearestPerson = targetToAdd
			SeeingTarget.append(targetToAdd)
	else:
		if SeeingTarget.size() > 0:
			for target in SeeingTarget:
				if target == targetToAdd:
					SeeingTarget.erase(targetToAdd)
			atack_component.NearestPerson = get_closest_target()
		
	if SeeingTarget.size() == 0:
		atack_component.NearestPerson =null

# ✅ Devuelve el target más cercano al owner o null si no hay nadie
func get_closest_target() -> Node2D:
	if SeeingTarget.is_empty():
		return null

	var closest : Node2D = SeeingTarget[0]
	var min_distance : float = owner.global_position.distance_to(closest.global_position)

	for target in SeeingTarget:
		if not is_instance_valid(target):
			continue
		var distance = owner.global_position.distance_to(target.global_position)
		if distance < min_distance:
			min_distance = distance
			closest = target

	return closest
