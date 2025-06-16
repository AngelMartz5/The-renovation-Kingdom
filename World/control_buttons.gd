extends Control
var buttonsChildren : Array = []
@onready var actionbuttons = $actionbuttons
@onready var controller = $"../Controller"
@onready var contenedor = $"."
@onready var boton_escena = preload("res://World/actionbuttons.tscn")


var needsmoreButtons : bool = false
var visibleactions = []
var buttonsVisibles = []
var actualButton : int= 0
var anteriorButton : int = 0
signal OrganizeButtons()

func _ready():
	buttonsChildren = obtener_botones()
	OrganizeButtons.connect(_organizeButtons)

func _changeButtons(datos: Array):
	var datosSize = datos.size()
	
	if actualButton + anteriorButton >= datosSize:
		actualButton = 0;
	else:
		actualButton += anteriorButton
	_aftersetTarget()

func _aftersetTarget():
	_visiblebuttons(owner.Myinformation.interact_component.accionesDisponiblesOther)
	actualizar_botones(self,visibleactions,boton_escena, needsmoreButtons)

func _organizeButtons():
	_posicionarButtons(buttonsVisibles)

func _visiblebuttons(arrayActions : Array):
	visibleactions.clear()
	var arraysize : Array = range(actualButton,arrayActions.size())
	var toTo : int = 0
	var actualpos :int = 0
	var varint : int = 0
	if arraysize.size() > 5:
		
		toTo = 4
		needsmoreButtons = true
		
	elif arraysize.size() == 5:
		
		toTo = 3
		needsmoreButtons = false
		
	elif arraysize.size() > 3:
		
		toTo = 2
		needsmoreButtons = true
		
	else:
	
		if arraysize.size() > 2:
			toTo = arraysize.size()-1
		else :
			toTo = arraysize.size()
		needsmoreButtons = false
		
	for action in arrayActions:
		if actualpos >= actualButton:
			if varint < toTo:
				visibleactions.append(action)
				varint += 1
		actualpos += 1
	anteriorButton = varint

func actualizar_botones(contenedor: Control, datos: Array, boton_escena: PackedScene, needsmore : bool) -> void:
	buttonsVisibles.clear()
	var total_datos = datos.size()
	var total_botones = contenedor.get_child_count()
	for i in contenedor.get_children():
		i.hide()
	# Mostrar o actualizar botones existentes
	for i in range(total_datos):
		var boton: Button
		if i < total_botones:
			boton = contenedor.get_child(i)
			boton.show()
			
		else:
			boton = boton_escena.instantiate()
			contenedor.add_child(boton)
		boton._changetype(SignalBus.ACTIONBUTTONS.SPECIAL, datos[i]["Name"], datos[i])
		buttonsVisibles.append(boton)
		#boton.text = str(datos[i]["Name"])	# o datos[i].nombre si es un objeto
	# Ocultar botones sobrantes
	var sobranters = range(total_datos, total_botones)
	if sobranters.size() != 0 || sobranters.size() > 1 and needsmore:
		var howmuch : int = 1
		if needsmore:
			howmuch +=2
		var acrualRotation : int= 0
		for i in sobranters:
			if acrualRotation > howmuch:
				contenedor.get_child(i).hide()
			elif acrualRotation == 0:
				var button : Button = contenedor.get_child(i)
				button.show()
				button._changetype(SignalBus.ACTIONBUTTONS.EXIT)
				buttonsVisibles.append(button)
			elif acrualRotation == 1:
				var button : Button = contenedor.get_child(i)
				button.show()
				button._changetype(SignalBus.ACTIONBUTTONS.MORE)
				buttonsVisibles.append(button)
			acrualRotation += 1
	else:
		if needsmore:
			var moreActions:Button
			moreActions = boton_escena.instantiate()
			contenedor.add_child(moreActions)
			moreActions._changetype(SignalBus.ACTIONBUTTONS.MORE)
			buttonsVisibles.append(moreActions)
		var moreActions:Button
		moreActions = boton_escena.instantiate()
		contenedor.add_child(moreActions)
		moreActions._changetype(SignalBus.ACTIONBUTTONS.EXIT)
		buttonsVisibles.append(moreActions)
	
	
	OrganizeButtons.emit()


func obtener_botones(contenedor: Node = self) -> Array:
	var botones = []
	for hijo in contenedor.get_children():
		if hijo is Button:
			botones.append(hijo)
	return botones
	
func _posicionarButtons(button_array: Array) -> void:
	var count := button_array.size()
	if count == 0:
		return
	var posCenter : Vector2 = controller.position + Vector2(-7,119)
	var distance := Vector2(65, 49)  # Distancia desde el centro en X y Y

	match count:
		1:
			# Un solo botón: centrado abajo
			button_array[0].position = posCenter + Vector2(0, distance.y)
		2:
			distance = Vector2(55, 35)
			# Dos botones: arriba izquierda y derecha
			button_array[0].position = posCenter + Vector2(-distance.x, -distance.y)
			button_array[1].position = posCenter + Vector2(distance.x, -distance.y)
		3:
			distance = Vector2(75, 25)
			# Triángulo invertido
			button_array[0].position = posCenter + Vector2(0, -distance.y * 1.5)
			button_array[1].position = posCenter + Vector2(-distance.x, distance.y * 0.5)
			button_array[2].position = posCenter + Vector2(distance.x, distance.y * 0.5)
		4:
			# Rombo o cuadrado
			button_array[0].position = posCenter + Vector2(0, -distance.y)     # arriba
			button_array[1].position = posCenter + Vector2(-distance.x, 0)     # izquierda
			button_array[2].position = posCenter + Vector2(distance.x, 0)      # derecha
			button_array[3].position = posCenter + Vector2(0, distance.y)      # abajo
		_:
			distance = Vector2(55, 0)
			# Usar polígono regular para 5 o más botones
			var lados = count
			var radio = max(distance.x, distance.y)

			for i in range(count):
				var angulo = TAU * i / lados - PI / 2  # empezar desde arriba (rotado 90°)
				var x = cos(angulo) * radio
				var y = sin(angulo) * radio
				button_array[i].position = posCenter + Vector2(x, y)
