extends Node
class_name Type
const ACCION = "accion"
const NAME = "Name"
const CANDOIT = "Can do it?"

@export var needSomething : bool = false
@export var errorMesaje : String = ""
@export var tipos : Array[String] = ["animal", "montable"]  # Ejemplo para caballo

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
				if valor != accion["condition_value"]:
					resultado["mensaje"] = accion["fail_message"]
					return resultado

			# Verificar uso limitado
			if accion["limited_uses"] and accion["uses"] >= accion["max_uses"]:
				resultado["mensaje"] = "Ya no puedes realizar esta acción más veces."
				return resultado

			# Llamar a la función de éxito si existe en el emisor
			var metodo = accion["function_on_success"]
			if emisor.information.mytype.has_method(metodo):
				emisor.information.mytype.call(metodo, receptor)
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


func get_acciones_validas_para_tipos(tipos_objetivo: Array[String]) -> Array:
	var acciones_validas := []

	for accion in TYPE.acciones:
		if accion.has("valid_types"):
			var tipos_validos = accion["valid_types"]
			
			# Si hay al menos un tipo compatible, la acción es válida
			var tiene_tipo_valido := false
			for tipo in tipos_objetivo:
				if tipo in tipos_validos:
					tiene_tipo_valido = true
					break
			
			if tiene_tipo_valido:
				acciones_validas.append(accion)
		else:
			# Si no se especifican tipos válidos, se asume que es válida para todos
			acciones_validas.append(accion)

	return acciones_validas


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
