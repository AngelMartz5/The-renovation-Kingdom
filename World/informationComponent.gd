extends Node
class_name INFORMATION

@onready var visuals = $"../Visuals"

@onready var movement = $"../Movement"
@onready var animation_component = $"../AnimationComponent"
@onready var gravity = $"../Gravity"
@onready var interact_component = $"../InteractComponent" as INTERACT
@onready var interact = $"../Interact" as InteractZone
@onready var collision_shape_2d = $"../CollisionShape2D" as CollisionShape2D
@onready var acomodation_component = $"../AcomodationComponent"

@export var velocidad_inicial : int = 150
@export var size : float = 3
@export var life : int = 100;
@export var distanceBetweenThem : float = 9
@export var NAME : String = ""
# Target es necesario especificarlo en cada personaje
var isonAction : bool = false
var Target : Node2D = null
# False = Derecha , True = izquierda
var DirectionFace : bool = false
