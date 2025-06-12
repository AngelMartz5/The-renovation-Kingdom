extends Node2D

@export var timeToStart : float = 2.0

func _ready():
	# Aquí cargas el mundo, el mapa, los enemigos, lo que sea...
	await get_tree().create_timer(timeToStart).timeout  # Simula que todo carga
	SignalBus.isallcompleted = true
	SignalBus.isCompleted.emit()
