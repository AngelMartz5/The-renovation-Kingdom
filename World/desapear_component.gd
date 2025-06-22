extends Node
@onready var disappear_timer = $DisappearTimer

@export var HowLowngStay : float = 2.0
@export var BehaviorAsANormalBullet : bool =true

func _ready():
	disappear_timer.wait_time = HowLowngStay
	if BehaviorAsANormalBullet:
		disappear_timer.start()

func _physics_process(delta):
	if owner.is_on_wall():
		owner.queue_free()

func _TimmerFinished():
	print("QUEUE FREE")
	owner.queue_free()
