extends Node
class_name Type
const ACCION = "accion"
const NAME = "Name"
const CANDOIT = "Can do it?"

@export var needSomething : bool = false
@export var errorMesaje : String = ""
@export var tipos : Array[String] = ["animal", "montable"]  # Ejemplo para caballo
@onready var information = $"../Information" as INFORMATION

var poseidoPor : PackedScene

func _CheckAction() -> String:
	if !needSomething:
		return ""
	return errorMesaje

func _accionAction():
	pass

func _actionSpecial():
	print("1")

func ejecutar_accion(emisor: Node, receptor: Node, nombre_accion: String) -> Dictionary:
	var resultado = {
		"exito": false,
		"mensaje": ""
	}

	# Buscar la acción en la lista de acciones
	for accion in TYPE.acciones:
		if accion["Name"] == nombre_accion:
			
			# Verificar si el receptor es del tipo válido
			var receptor_tipo = receptor.information.mytype.tipos
			var typeExist_receptor : bool = false
			if receptor_tipo != null:
				for typesReceptor in receptor_tipo:
					if typesReceptor in accion["valid_types"]:
						typeExist_receptor = true
						break
			if not typeExist_receptor:
				resultado["mensaje"] = "No puedes realizar esta acción sobre este objetivo."
				return resultado

			# Verificar si el emisor es del tipo válido
			var emisor_tipo = emisor.information.mytype.tipos
			var typeExist_emisor : bool = false
			if emisor_tipo != null:
				for typesEmisor in emisor_tipo:
					if typesEmisor in accion["allowed_types"]:
						typeExist_emisor = true
						break
			if not typeExist_emisor:
				resultado["mensaje"] = "No puedes ejecutar esta acción con este personaje."
				return resultado

			# Verificar condición si es necesaria
			if accion["requires_condition"]:
				var valor = receptor.information.get(accion["condition_key"])
				var conditionValue = accion["condition_key"] # puede ser true, false, 0, "Mage", etc.
				print(conditionValue)
				if conditionValue == "Poseido" || conditionValue == "Desposeido":
					var selfValue = emisor.information.get(accion["condition_key"])
					if selfValue != accion["condition_value"]:
						resultado["mensaje"] = accion["fail_message"]
						return resultado
					
				elif valor != accion["condition_value"]:
					resultado["mensaje"] = accion["fail_message"]
					return resultado

			# Verificar uso limitado
			if accion["limited_uses"] and accion["uses"] >= accion["max_uses"]:
				resultado["mensaje"] = "Ya no puedes realizar esta acción más veces."
				return resultado

			# Llamar a la función de éxito si existe en el emisor
			var metodo = accion["function_on_success"]
			if emisor.information.mytype.has_method(metodo):
				emisor.information.mytype.call(metodo, receptor.information.mytype)
				resultado["exito"] = true
				resultado["mensaje"] = "Acción ejecutada correctamente."

				# Incrementar uso si es limitado
				if accion["limited_uses"]:
					accion["uses"] += 1
			else:
				resultado["mensaje"] = "El emisor no tiene la función: %s." % metodo

			return resultado

	# Si no se encontró la acción
	resultado["mensaje"] = "Acción no encontrada."
	return resultado


func get_acciones_validas_para_tipos(tipos_objetivo: Array[String], tipos_emisor: Array[String]) -> Array:
	var acciones_validas := []

	for accion in TYPE.acciones:
		var es_valida := false

		# Verificar tipos válidos para el receptor (objetivo)
		if accion.has("valid_types"):
			for tipo in tipos_objetivo:
				if tipo in accion["valid_types"]:
					es_valida = true
					break
		else:
			es_valida = true  # si no hay restricción, es válida para todos

		# Verificar tipos válidos para el emisor
		if accion.has("allowed_types"):
			var tipo_valido_emisor := false
			for tipo in tipos_emisor:
				if tipo in accion["allowed_types"]:
					tipo_valido_emisor = true
					break
			es_valida = es_valida and tipo_valido_emisor
		# Si no hay restricción de emisor, no se modifica `es_valida`

		# Agregar la acción si es válida
		if es_valida:
			acciones_validas.append(accion)

	return acciones_validas

func Desposeer(receptor: Node) -> void:
	if self.information.movimiento_ai_prueba.controllPlayer:
		self.tipos.erase("fantasma")
		self.information.Poseido = false
		SignalBus.Actualworld.add_child(self.owner)
		var newGhost = SignalBus.NutShellPlayer._createPlayer(self.poseidoPor)
		self.information.movimiento_ai_prueba.controllPlayer = false
		receptor.information.movimiento_ai_prueba.controllPlayer = false
		newGhost.global_position = self.owner.global_position
		receptor.information.isonAction = false
		self.information.Poseido = false
		self.information.Desposeido = true
		self.information.isonAction = false
		print("Desposeido")

func Poseer(receptor: Node) -> void:
	receptor.poseidoPor = information.myScene
	if self.information.movimiento_ai_prueba.controllPlayer:
		receptor.tipos.append("fantasma")
		receptor.information.Poseido = true
		SignalBus.NutShellPlayer.ActualPlayer = receptor.owner
		receptor.information.movimiento_ai_prueba.controllPlayer = true
		receptor.information.Poseido = true
		receptor.information.Desposeido = false
	self.owner.queue_free()

func montar(receptor: Node) -> void:
	print("%s intentó montar a %s" % [self.name, receptor.name])

func alimentar(receptor: Node) -> void:
	print("%s alimentó a %s" % [self.name, receptor.name])

func acariciar(receptor: Node) -> void:
	print("%s acarició a %s" % [self.name, receptor.name])

func ordenar(receptor: Node) -> void:
	print("%s dio una orden a %s" % [self.name, receptor.name])

func curar_animal(receptor: Node) -> void:
	print("%s curó a un animal llamado %s" % [self.name, receptor.name])

func robar_animal(receptor: Node) -> void:
	print("%s robó al animal %s" % [self.name, receptor.name])

func hablar(receptor: Node) -> void:
	print("%s habló con %s" % [self.name, receptor.name])

func comerciar(receptor: Node) -> void:
	print("%s inició comercio con %s" % [self.name, receptor.name])

func robar_npc(receptor: Node) -> void:
	print("%s intentó robar a %s" % [self.name, receptor.name])

func ayudar(receptor: Node) -> void:
	print("%s ayudó a %s" % [self.name, receptor.name])

func interrogar(receptor: Node) -> void:
	print("%s interrogó a %s" % [self.name, receptor.name])

func curar_persona(receptor: Node) -> void:
	print("%s curó a la persona %s" % [self.name, receptor.name])

func abrir(receptor: Node) -> void:
	print("%s abrió a %s" % [self.name, receptor.name])

func mover(receptor: Node) -> void:
	print("%s movió a %s" % [self.name, receptor.name])

func romper(receptor: Node) -> void:
	print("%s rompió a %s" % [self.name, receptor.name])

func leer(receptor: Node) -> void:
	print("%s leyó a %s" % [self.name, receptor.name])

func usar(receptor: Node) -> void:
	print("%s usó a %s" % [self.name, receptor.name])

func atacar(receptor: Node) -> void:
	print("%s atacó a %s" % [self.name, receptor.name])

func robar_enemigo(receptor: Node) -> void:
	print("%s robó al enemigo %s" % [self.name, receptor.name])

func intimidar(receptor: Node) -> void:
	print("%s intimidó a %s" % [self.name, receptor.name])

func hablar_enemigo(receptor: Node) -> void:
	print("%s habló con el enemigo %s" % [self.name, receptor.name])

func hechizar(receptor: Node) -> void:
	print("%s hechizó a %s" % [self.name, receptor.name])

func invocar(receptor: Node) -> void:
	print("%s invocó frente a %s" % [self.name, receptor.name])

func ver_aura(receptor: Node) -> void:
	print("%s observó el aura de %s" % [self.name, receptor.name])
