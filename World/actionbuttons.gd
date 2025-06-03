extends Button



@export var type = SignalBus.ACTIONBUTTONS.EXIT
@export var timeToFinish : int = 30

@onready var first = $First
@onready var second = $Second
@onready var third = $Third
@onready var fourth = $Fourth

var pogressbars : Array[ProgressBar] 
var onTarget : bool = false
var currentbar : int = 0

signal completedsignal(yourType:SignalBus.ACTIONBUTTONS)


func _ready():
	self.text = SignalBus.ACTIONBUTTONS.find_key(type)
	pogressbars.insert(0,first)
	pogressbars.insert(1,second)
	pogressbars.insert(2,third)
	pogressbars.insert(3,fourth)
	_resetbar()
	self.visibility_changed.connect(_resetbar)

func _process(delta):
	if onTarget:
		_fillbars(.1)

func _resetbar():
	_cleanbars()
	_setTimeBars()

func _setTimeBars():
	var timeEach : int = timeToFinish / pogressbars.size()
	for bars in pogressbars:
		bars.max_value = timeEach

func _cleanbars():
	onTarget = false
	currentbar = 0
	for bars in pogressbars:
		bars.value = 0

func _fillbars(time : float):
	if currentbar < pogressbars.size():
		if pogressbars[currentbar].value >= pogressbars[currentbar].max_value:
			currentbar += 1
		else:
			pogressbars[currentbar].value +=time
	else:
		onTarget = false
		completedsignal.emit(type)
