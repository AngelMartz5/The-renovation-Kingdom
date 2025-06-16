extends Node
class_name AnimationComponent

enum animationsInHasAnimations{
	idle,
	walk,
	run,
	eat,
	notEat,
	getdamage,
	atack
}

@onready var animation_player = $"../AnimationPlayer" as AnimationPlayer
@onready var animation_tree = $"../AnimationTree" as AnimationTree
@export var ActionsAnmation : Array[String] = ["is_idle", "is_walk", "is_run", "is_eat", "isnot_eat", "get_damage" ,"is_atack"]
var especialAnim : String = ""
var obligated : String = "parameters/conditions/"
var beforeAnimation : Array[bool]

@export var hasAnimations : Array[bool] = [true,true,false,false,false,true,true]

func _ready():
	beforeAnimation = hasAnimations.duplicate()

func SetAnimationPlayer(ExactAnimation : animationsInHasAnimations):
	if !hasAnimations[ExactAnimation]:
		return
	
	#print("ENTRO: "+str(owner)+ "  PARA HACER: "+str(animationsInHasAnimations.find_key(ExactAnimation)))
	var where : int = 0
	for anim in hasAnimations:
		if especialAnim != "" and where == 0:
			var inside : String = obligated+ActionsAnmation[where]+especialAnim
			animation_tree[inside] = false
		
		if anim:
			animation_tree[obligated+ActionsAnmation[where]] = false
		where += 1
	
	if ExactAnimation == animationsInHasAnimations.idle:
		var inside : String = obligated+"is_idle"+especialAnim
		animation_tree[inside] = true
	else:
		animation_tree[obligated+ActionsAnmation[ExactAnimation]] = true
	
	if ExactAnimation != animationsInHasAnimations.atack:
		_recoverAnimation(ExactAnimation)
	
	

func _recoverAnimation(where : int):
	for before in beforeAnimation.size():
		beforeAnimation[before] = false
	
	beforeAnimation[where] = true

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
