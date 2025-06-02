extends Node


var textoPred : String = " ,Input: "

@onready var texto = $"../Label"
@onready var timer_text = $"../TimerText"

func _ready():
	
	INPUTS.changeInput.connect(_printInputs)
	timer_text.timeout.connect(_quitText)

func _input(event: InputEvent) -> void:
	if(
		event is InputEventKey
		and 
		event.is_released()
		||
		(event is InputEventMouseButton and event.pressed) 
		#|| event is InputEventJoypadButton
	):
		if event is InputEventMouseButton and event.double_click:
			event.double_click = false
		INPUTS._verificatyonInput(event)
		

func _printInputs(inputs : Array[InputEvent], actualInput : int):
	texto.text = ""
	for i in inputs.size():
		texto.text += textoPred + inputs[i].as_text().trim_suffix(" (Physical)")
	timer_text.start()

func _quitText():
	texto.text = ""
