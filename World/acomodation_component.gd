extends Node

@onready var information = $"../Information"
 
var needsAcomodation : bool = false
var other : Node2D
var Me : Node2D 
var distance: float = 0
var otherDistance : Vector2 = Vector2.ZERO
var real_position : Vector2 = Vector2.ZERO

func _process(delta):
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
	
	real_position = Me.global_position.direction_to(otherDistance)
	
	if real_position.x > 0.099 || real_position.x < -0.099:
		if real_position.x > 0:
			information.movement._movimiento(1)
		else:
			information.movement._movimiento(-1)
		
	else:
		information.movement._movimiento(0)
		var faceMe : bool = Me.information.DirectionFace
		print("REAL: "+str(real_position)+ "   My: " + str(Me.information.DirectionFace) + "  TARGET: " + str(other.information.DirectionFace))
		if faceMe == other.information.DirectionFace:
			
			Me.information.DirectionFace = !faceMe
		print("REAL: "+str(real_position)+ "   My: " + str(Me.information.DirectionFace) + "  TARGET: " + str(other.information.DirectionFace))
		_quitAcomodation()

func _quitAcomodation():
	needsAcomodation = false
