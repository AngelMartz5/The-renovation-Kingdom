extends Node
class_name AnimationComponent

enum animationsInHasAnimations{
	idle,#1
	walk,#2
	run,#3
	eat,#4
	notEat,#5
	getdamage,#6
	atack#7
}

@onready var animation_player = $"../AnimationPlayer" as AnimationPlayer
@onready var animation_tree = $"../AnimationTree" as AnimationTree
var especialAnim : String = ""
var obligated : String = "parameters/conditions/"
var beforeAnimation

@export var allActionsTogether = [
	{"is_idle" : true},#1
	{"is_walk" : true},#2
	{"is_run" : false},#3
	{"is_eat" :  false},#4
	{"isnot_eat" : false},#5
	{"get_damage" : true},#6
	{"is_atack" : true}#7
]

func _ready():
	beforeAnimation = allActionsTogether.duplicate()

func SetAnimationPlayer(ExactAnimation : animationsInHasAnimations):
	var accion = allActionsTogether[ExactAnimation]         # Esto es: {"is_idle": true}
	var nombre = accion.keys()[0]              # "is_idle"
	var valor = accion[nombre]                              # True o false
	
	
	if !valor:
		return
	
	#print("ENTRO: "+str(owner)+ "  PARA HACER: "+str(animationsInHasAnimations.find_key(ExactAnimation)) + " MAS : " + str(nombre))
	var where : int = 0
	for anim in allActionsTogether:   
		var nombreAnim = anim.keys()[0]  
		var valorAnim = anim[nombreAnim]
		if especialAnim != "" and where == 0:
			var inside : String = obligated+nombreAnim+especialAnim
			animation_tree[inside] = false
		
		if valorAnim:
			animation_tree[obligated+nombreAnim] = false
		where += 1
	
	if ExactAnimation == animationsInHasAnimations.idle:
		var inside : String = obligated+nombre+especialAnim
		animation_tree[inside] = true
	else:
		animation_tree[obligated+nombre] = true
	
	#if ExactAnimation != animationsInHasAnimations.atack:
	#	_recoverAnimation(ExactAnimation)
	
	

func _recoverAnimation(where : int):
	var where2: int = 0
	for before in allActionsTogether:
		var nombreAnim2 = before.keys()[0]  
		if where == where2:
			beforeAnimation[where][nombreAnim2] = true
		else:
			beforeAnimation[where2][nombreAnim2] = false
		where2 += 1
	
	

func convert_list_to_dict(list_of_dicts: Array) -> Dictionary:
	var result = {}
	for d in list_of_dicts:
		for key in d:
			result[key] = d[key]
	return result


func get_animation_length(anim_name: String) -> float:
	if animation_player.has_animation(anim_name):
		return animation_player.get_animation(anim_name).length
	else:
		push_warning("Animación no encontrada: " + anim_name)
		return 1.0

func _getBeforeAnimation()->animationsInHasAnimations:
	var where : int = 0
	var i :int = 0
	for before in beforeAnimation:
		if before:
			where = i
			break
		i += 1
	return where
