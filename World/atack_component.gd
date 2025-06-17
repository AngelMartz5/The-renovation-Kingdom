extends Node
class_name AttackComponent

@export var ArsenalDeAtaques = [
	{"Ataque1" : true },
	{"Ataque2" : false },
	{"Ataque3" : false },
	{"Ataque4" : false }
]
@export var cooldown: float = 1.0
@export var inmunityCoolDown : float = 1.0
@export var hasInmunity : bool = false
@export var AnimationTO : AnimationComponent.animationsInHasAnimations
@export var hasMoreAttacks : bool = false

@onready var health_component = $"../HealthComponent" as HealthComponent
@onready var animation_component = $"../AnimationComponent" as AnimationComponent
@onready var cooldown_timer = $CooldownTimer as Timer
@onready var imunity_timer = $ImunityTimer as Timer

var cooldownFinished : bool = true
var _can_attack := true
var _owner: Node = null
signal attacked(target)

func _ready():
	_owner = get_parent()
	cooldown_timer.wait_time = cooldown

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
	print("INMUNITY STARTED")
	_can_attack = false
	if imunity_timer.is_stopped():
		imunity_timer.start()

func _finishTimerCooldown():
	cooldownFinished = true

func _finishInmunityTimer():
	_can_attack = true
	print("FINISH INMUNITY")

func attack()->bool:
	var pudoAtacar = false
	
	if cooldownFinished:
		pudoAtacar = true
		cooldownFinished = false
		if !hasMoreAttacks:
			#EL 2.5 se puede quitar si le añado en un futuro velicidad de atque o algo similar que sea como RPG
			cooldown = animation_component.get_animation_length("Attack1") * 2.5
			cooldown_timer.wait_time = cooldown
			print("AYUDA: "+str(animation_component.get_animation_length("Attack1")))
		cooldown_timer.start()
		
	return pudoAtacar
