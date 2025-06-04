extends Node

@export var OWNER : CharacterBody2D
@onready var movement = $"../Movement"
@onready var information = $"../Information"

var movedir = 1;

func _process(delta):
	if !information.isonAction:
		if movement.wallColliding:
			movedir = -1
		movement._movimiento(movedir);
	else:
		movement._movimiento(0)
