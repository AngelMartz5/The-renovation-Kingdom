extends Node
class_name AttackComponent

enum AtacksAvalibles {
	Atack1,
	Atack2,
	Atack3,
	AtackEspecial
}
@export var NearestPerson : Node2D = null
@export var EspecialAtack : PackedScene 
@export var normalProjectiles : Array[PackedScene] = []
@export var ArsenalDeAtaques = [
	{"Attack1" : true  ,   "CanDo" : true  , "Number" : 0  ,"Nombre" : "Ataque Base"},
	{"Attack2" : false ,   "CanDo" : false , "Number" : 0 ,"Nombre" : "Ataque Secundario"},
	{"Attack3" : false ,   "CanDo" : false , "Number" : 0 ,"Nombre" : "Ataque Terciario"},
	{"AttackEsp" : false , "CanDo" : false , "Number" : 0 ,"Nombre" : "Ataque Especial"}
]
@export var cooldown: float = 1.0
@export var inmunityCoolDown : float = 1.0
@export var hasInmunity : bool = false
@export var AnimationTO : AnimationComponent.animationsInHasAnimations
@export var hasMoreAttacks : bool = true
@export var NumbersAvalibles : Array[int] = []
@export var ActualAttack : int = 0

@onready var health_component = $"../HealthComponent" as HealthComponent
@onready var animation_component = $"../AnimationComponent" as AnimationComponent
@onready var cooldown_timer = $CooldownTimer as Timer
@onready var imunity_timer = $ImunityTimer as Timer
@onready var atack = $"../State Machine/Atack" as Atack


var cooldownFinished : bool = true
var _can_attack := true
var _owner: Node = null
signal attacked(target)

signal CooldownCalculated(howMuch)

func _ready():
	_owner = get_parent()
	_setArsenal()
	cooldown_timer.wait_time = cooldown

func _getFromArsenal() -> String:
	var Name : String = ""
	for arsenal in ArsenalDeAtaques:
		var current = arsenal.keys()[0]
		if arsenal[current]:
			Name = current
	return Name

func _getAtackNumber(number : int) -> int:
	var value : int = 7
	var where : int = 0
	for arsenal in ArsenalDeAtaques:
		print(arsenal[arsenal.keys()[3]])
		if number == where:
			value = arsenal[arsenal.keys()[3]]
			return value
		where += 1
	return value

func _setArsenal(AtackA : int = AtacksAvalibles.Atack1 , canDoComponent : bool = false, NumberTONumber : int = 0):
	var Where : int = 0
	var placeArsenal : int = 0
	if canDoComponent:
		if AtackA == 0:
			NumbersAvalibles.clear()
			NumbersAvalibles.append(AtackA)
		else:
			NumbersAvalibles.append(AtackA)
		placeArsenal = 1
		for arsenal in ArsenalDeAtaques:
			var current = arsenal.keys()[placeArsenal]
			if Where == AtackA:
				arsenal[arsenal.keys()[3]] = NumberTONumber
				arsenal[current] = true
			Where += 1
	else:
		#print("NEAREST NUMBER: FROM:  " + str(AtackA)+ " TO: " +str(AtackSafe) +" POR PARTE DE: "+ str(owner))
		for arsenal in ArsenalDeAtaques:
			var current = arsenal.keys()[placeArsenal]
			arsenal[current] = false
			if Where == AtackA:
				arsenal[current] = true
			Where += 1

func _nextAttack():
	if NumbersAvalibles.size() <=1 or !hasMoreAttacks:
		return
	var NextAttack : int = ActualAttack +1
	ActualAttack = _find_nearest_forward(NextAttack)
	_setArsenal(ActualAttack)
	atack.AnimationTO = _getAtackNumber(ActualAttack)
	print(str(ActualAttack) + " Y ACTUAL DIALLOG: " + str(_getFromArsenal()) + " Y ESTE ANIMATIONTO: " + str(atack.AnimationTO))

func _appearProjectile():
	pass

func _appearArrow():
	if  normalProjectiles.size() == 0:
		return
	
	var aleatoriedad : int = randi_range(0,normalProjectiles.size())
	var projectile : Node2D = normalProjectiles[aleatoriedad].instantiate()
	SignalBus.Actualworld.add_child(projectile)

func _find_nearest_forward(number: int) -> int:
	if NumbersAvalibles.size() <=1:
		return 0
	
	var max_limit = ArsenalDeAtaques.size()
	var closest := -1
	var min_diff := INF

	for n in NumbersAvalibles:
		if n >= number and n < max_limit:
			var diff = n - number
			if diff < min_diff:
				min_diff = diff
				closest = n

	if closest == -1:
		return 0
	return closest



func try_attack(target: Node, damegeDic : Dictionary):
	if not _can_attack :
		return
	
	emit_signal("attacked", target)
	apply_attack(target, damegeDic)
 
func apply_attack(target: Node, damegeDic : Dictionary):
	var damage = damegeDic["damage"]
	print(damage)
	health_component.damage(damage)

func startInmunity():
	#print("INMUNITY STARTED")
	_can_attack = false
	if imunity_timer.is_stopped():
		imunity_timer.start()

func _finishTimerCooldown():
	cooldownFinished = true
	print("PUEDE ATACAR")

func _finishInmunityTimer():
	_can_attack = true
	#print("FINISH INMUNITY")

func attack()->bool:
	var pudoAtacar = false
	
	if cooldownFinished:
		pudoAtacar = true
		cooldownFinished = false
		
		#EL 2.5 se puede quitar si le añado en un futuro velicidad de atque o algo similar que sea como RPG
		var Wich : String = _getFromArsenal()
		cooldown = animation_component.get_animation_length(Wich) * 2.5
		CooldownCalculated.emit(cooldown)
		cooldown_timer.wait_time = cooldown
		#print("AYUDA: "+str(animation_component.get_animation_length("Attack1")))
		cooldown_timer.start()
		
	return pudoAtacar
