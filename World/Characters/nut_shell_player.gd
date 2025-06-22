extends Node2D

@export var FirstPlayer : Node2D
var ActualPlayer : Node2D  : set = _set_Player

var Myinformation : INFORMATION : set = _set_myInformation
var myinteract : InteractZone : set = _set_myinteract
var myinteract_component : INTERACT : set = _set_myinteract_component

@onready var text_actions = $TextActions
@onready var controller = $Controller
@onready var interact_camera_2d = $InteractCamera2D
@onready var nameLabel = $Controller/NAME
@onready var control_buttons = $Controller/ControlButtons
@onready var phantom_camera_2d = $"../PhantomCamera2D"
@onready var life_and_stamina_bar = $LifeAndStaminaBar as LifeBar
@onready var stamine_meter = $"Stamine-Meter" as StamineCircle

@export var ghost_escena : PackedScene = preload("res://World/Characters/Ghost.tscn")

@export var AnimationTO : AnimationComponent.animationsInHasAnimations

func _ready():
	SignalBus.SetEverything.connect(needesAfterReady)
	if FirstPlayer == null:
		var encontrado : bool = false
		for child in get_children():
			if child is CharacterBody2D:
				encontrado = true
				FirstPlayer = child
				break
		if !encontrado:
			var ghost = ghost_escena.instantiate()
			self.add_child(ghost)
			FirstPlayer = ghost


func needesAfterReady():
	SignalBus.NutShellPlayer = self
	ActualPlayer = FirstPlayer
	

func _set_Player(player : Node2D):
	if player != null:
		life_and_stamina_bar.OWNER = null
	ActualPlayer = player
	stamine_meter.OWNER = player
	Myinformation = player.information
	interact_camera_2d.follow_target = player
	life_and_stamina_bar.OWNER = player
	phantom_camera_2d.follow_target = player
	
func _set_myInformation(info : INFORMATION):
	if Myinformation != null:
		life_and_stamina_bar._setHealthComponent(Myinformation.health_component, false)
		Myinformation.interact_component.somebodyAvalible = false
	myinteract = info.interact
	Myinformation = info
	life_and_stamina_bar._setHealthComponent(Myinformation.health_component)
	
	myinteract_component = info.interact_component
	
	_changeControl(false)
	info.movimiento_ai_prueba.controllPlayer = true

func _set_myinteract(new : InteractZone):
	if  myinteract != null:
		myinteract.somebodyentered.disconnect(_somebodyentered)
	myinteract = new
	new.somebodyentered.connect(_somebodyentered)

func _set_myinteract_component(new : INTERACT):
	if myinteract_component != null:
		myinteract_component.setTarget.disconnect(control_buttons._aftersetTarget)
	myinteract_component = new
	myinteract_component.setTarget.connect(control_buttons._aftersetTarget)

func _process(delta):
	if SignalBus.isallcompleted and myinteract != null:
		life_and_stamina_bar.global_position = ActualPlayer.global_position


func _input(event):
	if SignalBus.isallcompleted and myinteract != null:
		if!Myinformation.isonAction:
			if event.is_action_pressed("ChangeAttack") :
				Myinformation.atack_component._nextAttack()
			if event.is_action_pressed("Atack") :
				Myinformation.stateAtack = true
				
		
		if event.is_action_pressed("Action") and Myinformation.interact_component.somebodyAvalible:
			Myinformation.interact_component._setTarget()
			_changeControl(true)
		
		if event.is_action_type() and Myinformation.Target != null:
			controller.global_position = ActualPlayer.global_position
			text_actions.global_position = ActualPlayer.global_position


func _somebodyentered(body:Node2D = null):
	var helpbool : bool = Myinformation.interact_component.somebodyAvalible
	_showTxtButtons(helpbool)
	if helpbool:
		interact_camera_2d.set_priority(11)
	else:
		interact_camera_2d.set_priority(0)
func _changeControl(bol:bool):
	var target = Myinformation.Target
	controller.visible = bol
	_showTxtButtons( false)
	if target != null:
		nameLabel.text = target.information.NAME
		Myinformation.interact_component._stopEverything(target,bol)
		if bol == true:
			var me : Node2D = ActualPlayer
			target.information.acomodation_component._setAcomodation(me, target, Myinformation.distanceBetweenThem)
		else :
			target.information.acomodation_component._quitAcomodation()
	else:
		Myinformation.interact_component._stopEverything(null, bol)
	
	

func _showTxtButtons(bol : bool = false):
	text_actions.visible = bol



func _createPlayer(scene : PackedScene) -> Node2D:
	var NewPlayer = scene.instantiate()
	self.add_child(NewPlayer)
	self.ActualPlayer = NewPlayer
	return NewPlayer
	
