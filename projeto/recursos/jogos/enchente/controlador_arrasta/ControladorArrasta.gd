extends Node2D


# Quando o arraste especifico é realizado. `chave` corresponde a uma string
#  definida em `vetores_de_mudanca`
signal arrastado(chave)

export var distancia_do_centro = 20
export var angulo = PI / 4


var toque_desfeito = true
var vetores_de_arraste = {
	'cima': 1,
	'baixo': 3,
	'esquerda': 2,
	'direita': 0,
}


func _on_ControleDeToque_arrastar_realizado(historico):
	if len(historico) < 2:
		return

	var delta_v: Vector2 = historico[-1] - historico[-2]
	for chave in vetores_de_arraste:
		var novo_angulo = vetores_de_arraste[chave]
		var rotacionado = delta_v.rotated(novo_angulo * PI / 2)
		if toque_desfeito and _ponto_no_angulo(rotacionado):
			emit_signal("arrastado", chave)
			toque_desfeito = false


func _ponto_no_angulo(ponto: Vector2):
	if ponto.x < 0:
		return false
	var novo_ponto = Vector2(abs(ponto.x), abs(ponto.y) - distancia_do_centro)
	var mudanca = atan(angulo / 2)
	if (novo_ponto.y < novo_ponto.x * mudanca) and (novo_ponto.y > -novo_ponto.x * mudanca):
		return true
	return false


func _on_ControleDeToque_toque_desfeito(historico):
	toque_desfeito = true
