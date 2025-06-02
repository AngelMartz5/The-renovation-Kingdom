extends Node

@onready var animation_tree = $"../AnimationTree"


func SetAnimationPlayer(idle : bool = false, walk : bool = false, run : bool = false):
	animation_tree["parameters/conditions/is_idle"] = idle
	animation_tree["parameters/conditions/is_walk"] =  walk
	animation_tree["parameters/conditions/is_run"] = run
