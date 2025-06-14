extends CharacterBody2D

@onready var information = $Information as INFORMATION
@onready var PROTOTYPE1 = preload("res://World/Characters/Prototype1.tscn")

func _ready():
	information.myScene = PROTOTYPE1
