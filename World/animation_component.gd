extends Node
class_name AnimationComponent

@onready var animation_tree = $"../AnimationTree" as AnimationTree
@export var ActionsAnmation : Array[String] = ["is_idle", "is_walk", "is_run", "is_eat", "isnot_eat", "is_trotando"]
var especialAnim : String = ""
var obligated : String = "parameters/conditions/"


func SetAnimationPlayer(idle : bool = true, walk : bool = false, run : bool = false):
	animation_tree[obligated+ActionsAnmation[1]] =  walk
	animation_tree[obligated+ActionsAnmation[2]] = run
	animation_tree[obligated+ActionsAnmation[0]+especialAnim] = idle
