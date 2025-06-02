extends Node

@export var OWNER : CharacterBody2D
@onready var movement = $"../Movement"

var movedir = 1;

func _process(delta):
	if movement.wallColliding:
		movedir = -1
	movement._movimiento(movedir);
