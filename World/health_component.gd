extends Node
class_name  HealthComponent

signal died()
signal ChangeLife
@onready var atack_component = $"../AtackComponent" as AttackComponent
@onready var animation_component = $"../AnimationComponent" as AnimationComponent
@export var max_health : float = 10
var current_health : float = 1.0 : set = _current_health
@onready var information = $"../Information" as INFORMATION

func _ready() -> void:
	current_health = max_health

func damage(damage_mount : float):
	current_health = max(current_health - damage_mount, 0)
	ChangeLife.emit()
	Callable(check_death).call_deferred()

func _current_health(current : float):
	print("BEGORE: "+str(current_health) + " NOW LIFE: "+str(current))
	if current < current_health:
		information.gotDamage = true
	current_health = current
	

func get_health_percent() -> float:
	if max_health <= 0:
		return 0
	var ayuda : float = min(current_health / max_health, 1)
	
	return ayuda


func check_death():
	if current_health <= 0:
		died.emit()
