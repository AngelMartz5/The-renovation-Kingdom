extends CharacterBody2D

@onready var information = $Information
@onready var GHOST = preload("res://World/Characters/Ghost.tscn")

func _ready():
	information.myScene = GHOST
	print("APARECI")
