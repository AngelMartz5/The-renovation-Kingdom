extends Node
class_name INFORMATION

@onready var visuals = $"../Visuals"

@onready var movement = $"../Movement"
@onready var animation_component = $"../AnimationComponent"
  
@export var velocidad_inicial : int = 150
@export var size : float = 3
@export var life : int = 100;

var isonAction : bool = false
