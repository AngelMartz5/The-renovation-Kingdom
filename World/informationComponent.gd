extends Node
class_name INFORMATION

@onready var visuals = $"../Visuals"

@onready var movement = $"../Movement"
@onready var animation_component = $"../AnimationComponent" as AnimationComponent
@onready var gravity = $"../Gravity"
@onready var health_component = $"../HealthComponent" as HealthComponent
@onready var interact_component = $"../InteractComponent" as INTERACT
@onready var interact = $"../Interact" as InteractZone
@onready var collision_shape_2d = $"../CollisionShape2D" as CollisionShape2D
@onready var acomodation_component = $"../AcomodationComponent" as Acomodation
@onready var movimiento_ai_prueba = $"../MovimientoAiPrueba" as MovementAI
@onready var animated_sprite_2d = $"../Visuals/AnimatedSprite2D" as AnimatedSprite2D
@onready var atack_component = $"../AtackComponent" as AttackComponent
@onready var area_atack = $"../Visuals/AreaAtack" as AreaAttack
@onready var area_vision = $"../Visuals/AreaVision" as AreaVision

@export var velocidad_inicial : int = 150
@export var mytype : Type
@export var distanceBetweenThem : float = 9
@export var NAME : String = ""
@export var isPeaceful : bool = true
@export var NearestPerson : Node2D = null
@export var isPlayerFallen : bool = false

var seParaParaAtacar : bool = false
# Target es necesario especificarlo en cada personaje
var atacking : bool = false
var jumped : bool = false
var myScene : PackedScene
var isonAction : bool = false
var Target : Node2D = null
# False = Izquierda , True = Derecha
var DirectionFace : bool = false
var needsAcomodation : bool = false
var canCharacterJump: bool = true
var gotDamage : bool = false
var stateAtack : bool = false
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
var Poseido : bool = false
var Desposeido : bool = true
