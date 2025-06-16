extends Area2D
class_name AreaAttack

# Enums para tipos de ataque y tipos elementales
enum AttackType { DIRECT, DOT }
enum ElementType { PHYSICAL, FIRE, POISON, ICE, MAGIC }

var targetToAttack : Array[Node2D] = []
@export var onlyOneTarget : bool = false
@export var attack_type: AttackType = AttackType.DIRECT
@export var element_type: ElementType = ElementType.PHYSICAL
@export var damage: int = 10
@export var duration: float = 0.0 # Solo para DOT
@export var tick_interval: float = 1.0 # Solo para DOT
@export var DetenerseAlAtacar : bool = true
@export var AnimationTO : AnimationComponent.animationsInHasAnimations
@onready var information = $"../../Information"

#Aqui poner que haga la accion de atackar y que pueda detectar quien esta dentro de su area 
func _ready():
	body_entered.connect(_targetAppeard)
	body_exited.connect(_targetDesappeard)
	information.seParaParaAtacar = DetenerseAlAtacar


func _targetAppeard(body:Node2D):
	if body == owner:
		return
	print("ENTRO:  " + str(body))
	_searchTarget(body,)

func _targetDesappeard(body:Node2D):
	_searchTarget(body,false)

func _searchTarget(targetToAdd : Node2D, agregar : bool = true):
	if agregar:
		if onlyOneTarget:
			if targetToAttack.size() > 0:
				targetToAttack[0] = targetToAdd
			else:
				targetToAttack.append(targetToAdd)
			return
		
		if targetToAttack.size() > 0:
			for target in targetToAttack:
				if target == targetToAdd:
					return
			targetToAttack.append(targetToAdd)
		else:
			targetToAttack.append(targetToAdd)
	else:
		if onlyOneTarget:
			if targetToAttack.size() > 0:
				targetToAttack[0] = null
			else:
				targetToAttack.erase(targetToAdd)
			return
		
		if targetToAttack.size() > 0:
			for target in targetToAttack:
				if target == targetToAdd:
					targetToAttack.erase(targetToAdd)

func _hacerDaño():
	if targetToAttack.size() <= 0:
		return
	
	var attack_info = {
		"type": attack_type,
		"element": element_type,
		"damage": damage,
		"duration": duration,
		"tick_interval": tick_interval,
	}
	print(targetToAttack)
	if onlyOneTarget:
		var targetAttack = targetToAttack[0]
		targetAttack.information.atack_component.try_attack(targetAttack, attack_info)
	
	for target in targetToAttack:
		target.information.atack_component.try_attack(target, attack_info)
