extends Node
class_name AnimationComponent

enum animationsInHasAnimations{
	idle,#1
	walk,#2
	run,#3
	eat,#4
	notEat,#5
	getdamage,#6
	jump, #11
	fallen,  #12
	land,  #13
	roll, # 14
	atack1,#7
	atack2,#8
	atack3,#9
	atackEsp, #10
}
@onready var atack_component = $"../AtackComponent" as AttackComponent
@onready var animation_player = $"../AnimationPlayer" as AnimationPlayer
@onready var animation_tree = $"../AnimationTree" as AnimationTree
var especialAnim : String = ""
var obligated : String = "parameters/conditions/"
var beforeAnimation : int = 0
var onAnimation : bool = false

@export var allActionsTogether = [
	{"is_idle" : true},#1
	{"is_walk" : true},#2
	{"is_run" : false},#3
	{"is_eat" :  false},#4
	{"isnot_eat" : false},#5
	{"get_damage" : true},#6
	{"is_jump" : false}, # 11
	{"is_fallen" : false},  #12
	{"is_land" : false},  # 13
	{"is_rolling" : false}, # 14
	{"is_atack" : true},#7
	{"is_atack2" : false},#8
	{"is_atack3" : false},#9
	{"is_atackEsp" : false} #10
]

func _ready():
	_actualizarAtack()

func GetAnimationPlayer(ExactAnimation : animationsInHasAnimations) -> bool :
	var accion = allActionsTogether[ExactAnimation]         # Esto es: {"is_idle": true}
	var nombre = accion.keys()[0]              # "is_idle"
	var valor = accion[nombre]     
	
	if valor:
		return true
	
	return false

func SetAnimationPlayer(ExactAnimation : animationsInHasAnimations) -> bool:
	onAnimation = true
	var accion = allActionsTogether[ExactAnimation]         # Esto es: {"is_idle": true}
	var nombre = accion.keys()[0]              # "is_idle"
	var valor = accion[nombre]                              # True o false
	
	
	
	if !valor:
		onAnimation = false
		return false
	
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
		print("Entro para hacer : " +str(nombre))
		animation_tree[obligated+nombre] = true
	
	if ExactAnimation == animationsInHasAnimations.idle or ExactAnimation == animationsInHasAnimations.walk or ExactAnimation == animationsInHasAnimations.run or ExactAnimation == animationsInHasAnimations.fallen:
		beforeAnimation = ExactAnimation
	onAnimation = false
	return true

func _actualizarAtack():
	var where : int = 0
	var where2 : int =0
	for anim in allActionsTogether:   
		if where >= animationsInHasAnimations.atack1:
			var nombreAnim = anim.keys()[0]  
			var valorAnim = anim[nombreAnim]
			if valorAnim:
				atack_component._setArsenal(where2, true, where)
			where2+=1
		where += 1
		

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
