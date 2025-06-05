extends Node

@export var OWNER : CharacterBody2D
@onready var movement = $"../Movement"
@onready var information = $"../Information"

var movedir = 1;

func _process(delta):
	if !information.isonAction and !information.acomodation_component.needsAcomodation:
		if movement.wallColliding:
			movedir = -1
		movement._movimiento(movedir);
	else:
		pass
