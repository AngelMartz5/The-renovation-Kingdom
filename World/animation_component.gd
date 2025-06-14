extends Node
class_name AnimationComponent

enum animationsInHasAnimations{
	idle,
	walk,
	run,
	eat,
	notEat
}

@onready var animation_tree = $"../AnimationTree" as AnimationTree
@export var ActionsAnmation : Array[String] = ["is_idle", "is_walk", "is_run", "is_eat", "isnot_eat"]
var especialAnim : String = ""
var obligated : String = "parameters/conditions/"

@export var hasAnimations : Array[bool] = [true,true,false,false,false,false]

func SetAnimationPlayer(idle : bool = true, walk : bool = false, run : bool = false):
	animation_tree[obligated+ActionsAnmation[1]] =  walk
	if run:
		if hasAnimations[animationsInHasAnimations.run]:
			animation_tree[obligated+ActionsAnmation[2]] = run
	animation_tree[obligated+ActionsAnmation[0]+especialAnim] = idle
