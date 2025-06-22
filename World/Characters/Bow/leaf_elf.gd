extends CharacterBody2D

@onready var information = $Information as INFORMATION

@onready var LEAFELF = preload("res://World/Characters/Bow/leaf_elf.tscn")

func _ready():
	information.myScene = LEAFELF
