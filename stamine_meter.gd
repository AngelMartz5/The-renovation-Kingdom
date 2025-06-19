extends Node2D
class_name StamineCircle

var OWNER : Node2D = null : set = _set_Owner

var Value = 0.0
var max_value = 0.0
var current_angle = -1.6
var fade_opacity = 1.0
var fade_speed = 1.5 # velocidad de desvanecimiento

var min_angle = -1.6
var max_angle = 4.7

@onready var nut_shell_player = $".."

func _draw():
	if nut_shell_player.ActualPlayer != null and (Value < max_value or fade_opacity > 0):
		var player_pos = to_local(nut_shell_player.ActualPlayer.global_position)
		var pos = player_pos + Vector2(0, -30)

		# Interpolación del color de gris (inicio) a azul (fin)
		var t = clamp(Value / max_value, 0, 1)
		var fill_color = Color("#aaaaaa").lerp(Color("#3dbfff"), t)
		fill_color.a *= fade_opacity # aplicar transparencia

		var bg_color = Color(0.2, 0.2, 0.2, 0.4 * fade_opacity)

		draw_stamina_meter(pos, 10, 10, current_angle, fill_color, bg_color)

func _set_Owner(newOwner: Node2D):
	if newOwner != null:
		OWNER = newOwner
		OWNER.information.atack_component.CooldownCalculated.connect(_getCooldown)
	else:
		if OWNER != null:
			OWNER.information.atack_component.CooldownCalculated.disconnect(_getCooldown)

func draw_stamina_meter(pos, size, width, current , color, bg_color):
	# Fondo
	draw_arc(pos, size, max_angle, min_angle, 800, bg_color, width, true)
	# Barra
	draw_arc(pos, size, max_angle, current, 800, color, width, true)

func _getCooldown(cooldwn):
	Value = 0.0
	max_value = cooldwn
	fade_opacity = 1.0 # reiniciar el fade si estaba en 0

func _process(delta):
	if Value < max_value:
		Value += delta
		Value = clamp(Value, 0, max_value)

		var t = clamp(Value / max_value, 0, 1)
		current_angle = lerp(max_angle, min_angle, t)
	else:
		# cuando ya terminó el cooldown, empieza a desvanecer
		if fade_opacity > 0:
			fade_opacity -= delta * fade_speed
			fade_opacity = clamp(fade_opacity, 0, 1)

	queue_redraw()
