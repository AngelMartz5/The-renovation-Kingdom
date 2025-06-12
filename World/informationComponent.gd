extends Node
class_name INFORMATION

@onready var visuals = $"../Visuals"

@onready var movement = $"../Movement"
@onready var animation_component = $"../AnimationComponent" as AnimationComponent
@onready var gravity = $"../Gravity"
@onready var interact_component = $"../InteractComponent" as INTERACT
@onready var interact = $"../Interact" as InteractZone
@onready var collision_shape_2d = $"../CollisionShape2D" as CollisionShape2D
@onready var acomodation_component = $"../AcomodationComponent" as Acomodation
@onready var movimiento_ai_prueba = $"../MovimientoAiPrueba" as MovementAI
@onready var animated_sprite_2d = $"../Visuals/AnimatedSprite2D" as AnimatedSprite2D

@export var velocidad_inicial : int = 150
@export var size : float = 3
@export var life : int = 100;
@export var mytype : Type
@export var distanceBetweenThem : float = 9
@export var NAME : String = ""

# Target es necesario especificarlo en cada personaje
var isonAction : bool = false
var Target : Node2D = null
# False = Izquierda , True = Derecha
var DirectionFace : bool = false

# === Condiciones para acciones ===

var domesticado: bool = false
var entrenado: bool = false
var salud_baja: bool = true
var disponible: bool = false
var necesita_ayuda: bool = false
var capturado: bool = false
var herido: bool = false
var cerrado: bool = true
var fragil: bool = false
var legible: bool = false
var usable: bool = false
var miedo: bool = false
var cooperativo: bool = false
var no_protegido: bool = true
var mana_suficiente: bool = true
var habilidad_aura: bool = false
