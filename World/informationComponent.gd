extends Node
class_name INFORMATION

@onready var visuals = $"../Visuals"

@onready var movement = $"../Movement"
@onready var animation_component = $"../AnimationComponent"
@onready var gravity = $"../Gravity"
@onready var interact_component = $"../InteractComponent" as INTERACT
@onready var interact = $"../Interact" as InteractZone

@export var velocidad_inicial : int = 150
@export var size : float = 3
@export var life : int = 100;
@export var NAME : String = ""

var isonAction : bool = false
var Target : Node2D = null
