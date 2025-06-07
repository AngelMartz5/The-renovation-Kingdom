extends Type

@onready var information = $"../Information" as INFORMATION

@export var EqupedSmall : bool = false
@export var EqupedBig : bool = false
var NoEqupped : bool = false
@onready var black_horse = $".."

func _ready():
	_actionSpecial()
	if EqupedSmall:
		_ChangeEquipped(true)
	elif EqupedBig:
		_ChangeEquipped(false,true)
	else:
		_ChangeEquipped()

func _ChangeEquipped(small : bool = false, big : bool = false):
	EqupedSmall = false
	EqupedBig = false
	NoEqupped = false
	if small:
		EqupedSmall = true
		information.animation_component.especialAnim = "ES"
	elif big:
		EqupedBig = true
		information.animation_component.especialAnim = "EB"
	else:
		NoEqupped = true
		information.animation_component.especialAnim = ""
	

func _actionSpecial():
	print("2")
