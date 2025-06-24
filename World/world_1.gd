extends Node2D

@export var timeToStart : float = 2.0

func _ready():
	# Aquí cargas el mundo, el mapa, los enemigos, lo que sea...g
	SignalBus.Actualworld = self
	await get_tree().create_timer(timeToStart/4).timeout
	SignalBus.AnimationSets
	await get_tree().create_timer(timeToStart/2).timeout  # Simula que todo carga
	SignalBus.SetEverything.emit()
	await get_tree().create_timer(timeToStart).timeout  # Simula que todo carga
	SignalBus.isCompleted.emit()
	SignalBus.isallcompleted = true
	
	print("MY WoRld:  "+str(get_tree().root.get_child(0)) )
