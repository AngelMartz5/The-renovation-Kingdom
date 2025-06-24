extends Area2D
class_name AreaAttack

# Enums para tipos de ataque y tipos elementales
enum AttackType { DIRECT, DOT }
enum ElementType { PHYSICAL, FIRE, POISON, ICE, MAGIC }

var targetToAttack : Array[Node2D] = []
@export var onlyOneTarget : bool = false
@export var DestroyAfterDamage : bool = false
@export var DetenerseAlAtacar : bool = true
@export var attack_type: AttackType = AttackType.DIRECT : set = _setAttackType
@export var element_type: ElementType = ElementType.PHYSICAL
@export var damage: float = 10.0
@export var duration: float = 0.0 # Solo para DOT
@export var tick_interval: float = 1.0 # Solo para DOT
@export var AtacarSolo :bool = false : set = _setAlreadyAttackArray
var tagetAlreadyAttack : Array[Node2D] = [] 
@onready var information = $"../../Information"
@onready var timer_attack = $TimerAttack as Timer
var RealDamage : float = 0.0


#Aqui poner que haga la accion de atackar y que pueda detectar quien esta dentro de su area 
func _ready():
	body_entered.connect(_targetAppeard)
	body_exited.connect(_targetDesappeard)
	information.seParaParaAtacar = DetenerseAlAtacar
	

func _targetAppeard(body:Node2D):
	if body == owner:
		return
	_searchTarget(body,)
	if AtacarSolo:
		_searchTarget(body, true, tagetAlreadyAttack)
		if attack_type == AttackType.DOT and element_type == ElementType.PHYSICAL:
			return
		_hacerDaño(tagetAlreadyAttack)
		_searchTarget(body, false, tagetAlreadyAttack)
		

func _setAlreadyAttackArray(value : bool):
	if value:
		tagetAlreadyAttack = targetToAttack.duplicate(true)
	AtacarSolo = value

func _initDamageContinuo():
	if timer_attack.is_stopped():
		print("ENTRO _initDamageContinuo")
		timer_attack.wait_time = tick_interval
		timer_attack.start()
		

func _FinishTimer():
	timer_attack.stop()
	if DestroyAfterDamage:
		owner.queue_free()

func _targetDesappeard(body:Node2D):
	_searchTarget(body,false)
	if attack_type == AttackType.DOT and element_type == ElementType.PHYSICAL:
		_searchTarget(body, false, tagetAlreadyAttack)

func _AfterTimer():
	_hacerDaño(tagetAlreadyAttack)

func _searchTarget(targetToAdd : Node2D, agregar : bool = true,WichArray : Array[Node2D] = targetToAttack):
	if agregar:
		if onlyOneTarget:
			if WichArray.size() > 0:
				WichArray[0] = targetToAdd
			else:
				WichArray.append(targetToAdd)
			return
		
		if WichArray.size() > 0:
			for target in WichArray:
				if target == targetToAdd:
					return
			WichArray.append(targetToAdd)
		else:
			WichArray.append(targetToAdd)
	else:
		if onlyOneTarget:
			if WichArray.size() > 0:
				WichArray[0] = null
			else:
				WichArray.erase(targetToAdd)
			return
		
		if WichArray.size() > 0:
			for target in WichArray:
				if target == targetToAdd:
					WichArray.erase(targetToAdd)

func _hacerDaño(WichArray : Array[Node2D] = targetToAttack):
	if WichArray.size() <= 0:
		return
	
	var attack_info = {
		"type": attack_type,
		"element": element_type,
		"damage": damage,
		"duration": duration,
		"tick_interval": tick_interval,
	}
	if DestroyAfterDamage and attack_type != AttackType.DOT:
		var targetAttack = WichArray[0]
		targetAttack.information.health_component.ChangeLife.connect(_hitEnemy)
	if onlyOneTarget:
		var targetAttack = WichArray[0]
		
		targetAttack.information.atack_component.try_attack(targetAttack, attack_info)
	else:
		for target in WichArray:
			target.information.atack_component.try_attack(target, attack_info)

func _hitEnemy():
	owner.queue_free()

func _setAttackType(NewType : AttackType):
	if NewType == AttackType.DOT:
		if damage > 1 and RealDamage == 0:
			RealDamage = damage
			damage /= 5
	else:
		if RealDamage != 0:
			damage = RealDamage
			RealDamage = 0
	attack_type = NewType
