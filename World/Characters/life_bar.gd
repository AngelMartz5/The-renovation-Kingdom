extends Control
class_name LifeBar

@onready var damage_bar: ProgressBar = $LifeProgressBar/DamageProgressBar
@onready var timer: Timer = $Timer
@onready var life_progress_bar = $LifeProgressBar

@export var OWNER : Node2D


var health : int = 0 : set = _set_health

func _setHealthComponent(healt : HealthComponent, add : bool = true):
	if add:
		init_health(healt.max_health)
		healt.ChangeLife.connect(update_health_display)
	else:
		healt.ChangeLife.disconnect(update_health_display)

func update_health_display():
	if OWNER != null:
		life_progress_bar.value = OWNER.information.health_component.current_health

func _set_health(new_health: int):
	var prev_health = health
	health = new_health
	health = min(life_progress_bar.max_value,new_health)
	life_progress_bar.value = health
	
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func init_health(_health : int):
	health = _health
	life_progress_bar.max_value = health
	life_progress_bar.value = health
	damage_bar.max_value = health
	damage_bar.value = health


func _on_timer_timeout() -> void:
	damage_bar.value = health
