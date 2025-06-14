extends Node
class_name Acomodation

@onready var information = $"../Information"
 
var needsAcomodation : bool = false
var other : Node2D
var Me : Node2D 
var distance: float = 0
var otherDistance : Vector2 = Vector2.ZERO
var real_position : Vector2 = Vector2.ZERO

func _physics_process(delta):
	if needsAcomodation:
		_acomodationFunc()

func _setAcomodation(otherset : Node2D, meset : Node2D = self.owner, dis : float = 0):
	other = otherset
	Me = meset
	otherDistance = otherset.global_position
	if dis !=0:
		if other.information.DirectionFace:
			otherDistance.x += dis
		else:
			otherDistance.x -= dis
	else:
		distance = dis
	needsAcomodation = true
	

func _acomodationFunc():
	if Me.information.movement._FromtoTo(Me.global_position,otherDistance, Me):
		var faceMe : bool = Me.information.DirectionFace
		if faceMe == other.information.DirectionFace:
			Me.information.DirectionFace = !faceMe
		
		_quitAcomodation()

func _quitAcomodation():
	needsAcomodation = false
