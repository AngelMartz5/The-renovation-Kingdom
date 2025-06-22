extends Control
class_name LifeBar

@onready var damage_bar: ProgressBar = $LifeProgressBar/DamageProgressBar
@onready var timer_damage = $TimerDamage

@onready var life_progress_bar = $LifeProgressBar

@export var OWNER : Node2D


var health : int = 0 : set = _set_health

func _setHealthComponent(healt : HealthComponent, add : bool = true):
	if add:
		if healt.current_health != healt.max_health:
			init_health(healt.max_health, healt.current_health )
		else:
			init_health(healt.max_health)
		healt.ChangeLife.connect(update_health_display)
	else:
		healt.ChangeLife.disconnect(update_health_display)

func update_health_display():
	if OWNER != null:
		health = OWNER.information.health_component.current_health

func _set_health(new_health: int):
	var prev_health = health
	#health = new_health
	health = min(life_progress_bar.max_value,new_health)
	life_progress_bar.value = health
	print("Previous: "+ str(prev_health) + "  ACTUAL HEALTH: "+str(health))
	if health < prev_health:
		
		timer_damage.start()
	else:
		damage_bar.value = health

func _aftertimer_damage():
	
	damage_bar.value = health

func init_health(_health : int, currentHealth : float = -1):
	if currentHealth != -1:
		health = currentHealth
		life_progress_bar.max_value = _health
		life_progress_bar.value = health
		damage_bar.max_value = _health
		damage_bar.value = health
	else:
		health = _health
		life_progress_bar.max_value = health
		life_progress_bar.value = health
		damage_bar.max_value = health
		damage_bar.value = health
