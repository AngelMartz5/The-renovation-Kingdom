extends Node

var inputsDelay : Array[InputEvent]
var actualPosArray : int = 0
var overload : bool = false

signal changeInput(inputs : Array[InputEvent], actualInput : int)

func _ready():
	overload = false

func _verificatyonInput(event : InputEvent):
	
	if overload:
		inputsDelay.remove_at(0+actualPosArray)
	
	inputsDelay.insert(actualPosArray, event)
	if(actualPosArray >= 3):
		actualPosArray = 0
		overload = true
	else:
		actualPosArray += 1
	changeInput.emit(inputsDelay,actualPosArray)
