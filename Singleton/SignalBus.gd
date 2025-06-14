extends Node

enum ACTIONBUTTONS{
	EXIT,
	MORE,
	SPECIAL,
	DIALOG
}

var isallcompleted : bool = false

signal isCompleted()
signal SetEverything()

var Actualworld : Node2D
var NutShellPlayer : Node2D
