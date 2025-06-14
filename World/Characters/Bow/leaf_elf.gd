extends CharacterBody2D

@onready var information = $Information

@onready var LEAFELF = preload("res://World/Characters/Bow/leaf_elf.tscn")

func _ready():
	information.myScene = LEAFELF
