extends CharacterBody2D

@onready var information = $Information as INFORMATION

@onready var MAULER =  preload("res://World/Characters/Sword/Mauler.tscn")

func _ready():
	information.myScene = MAULER
	print("BULLETAPEARED")
