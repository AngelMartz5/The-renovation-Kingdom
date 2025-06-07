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
			var receptor_tipo = receptor.get("tipo") if receptor.has_method("get") else null
			if receptor_tipo == null or not receptor_tipo in accion["valid_types"]:
				resultado["mensaje"] = "No puedes realizar esta acción sobre este objetivo."
				return resultado

			# Verificar condición si es necesaria
			if accion["requires_condition"]:
				var valor = receptor.get(accion["condition_key"]) if receptor.has_method("get") else null
				if valor != accion["condition_value"]:
					resultado["mensaje"] = accion["fail_message"]
					return resultado

			# Verificar uso limitado
			if accion["limited_uses"] and accion["uses"] >= accion["max_uses"]:
				resultado["mensaje"] = "Ya no puedes realizar esta acción más veces."
				return resultado

			# Llamar a la función de éxito si existe en el emisor
			var metodo = accion["function_on_success"]
			if emisor.has_method(metodo):
				emisor.call(metodo, receptor)  # Se le pasa el objetivo
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
