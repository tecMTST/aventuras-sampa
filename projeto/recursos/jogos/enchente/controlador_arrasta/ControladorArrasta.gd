extends Node2D


# Quando o arraste especifico é realizado. `chave` corresponde a uma string
#  definida em `vetores_de_mudanca`
signal arrastado(chave)

export var distancia_do_centro: int = 10
export var angulos_arraste = {
	'esquerda-0': {'minimo': 150, 'maximo': 190},
	'esquerda-1': {'minimo': -190, 'maximo': -150},
	'direita': {'minimo': -30, 'maximo': 30}
}


var toque_desfeito = true


func adicionar_angulo(chave: String, minimo: float, maximo: float):
	angulos_arraste[chave] = {'minimo': minimo, 'maximo': maximo}


func _on_ControleDeToque_arrastar_realizado(historico):
	if len(historico) < 3:
		return

	var delta_v: Vector2 = historico[-1] - historico[-3]

	if delta_v.length_squared() < distancia_do_centro ^ 2:
		return

	for chave in angulos_arraste:
		var angulo_vetor = delta_v.angle()
		var limite = angulos_arraste[chave]
		if toque_desfeito and (angulo_vetor > deg2rad(limite['minimo'])) and (angulo_vetor < deg2rad(limite['maximo'])):
			emit_signal("arrastado", chave)
			toque_desfeito = false


func _on_ControleDeToque_toque_desfeito(historico):
	toque_desfeito = true
