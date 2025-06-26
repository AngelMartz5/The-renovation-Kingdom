extends Node
@onready var disappear_timer = $DisappearTimer

@export var HowLowngStay : float = 2.0
@export var BehaviorAsANormalBullet : bool =true
func _ready():
	disappear_timer.wait_time = HowLowngStay


func _TimmerFinished():
	owner.queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	if BehaviorAsANormalBullet:
		disappear_timer.start()
