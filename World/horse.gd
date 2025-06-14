extends CharacterBody2D
class_name Interactuable

@onready var information = $Information
@onready var BLACKHORSE = preload("res://World/Characters/Blackhorse.tscn")

func _ready():
	information.myScene = BLACKHORSE
