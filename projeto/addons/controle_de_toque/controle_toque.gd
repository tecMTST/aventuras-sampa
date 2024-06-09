extends Node

signal coordenadas_de_toque_y #(coordenadas y)
signal coordenadas_de_toque_x #(coordenadas x)
signal toque_realizado #toque realizado
signal toque_desfeito #toque desfeito

export var tamanho_array = 2 #Tamanho total que a array pode chegar

onready var viewport_modificador = get_viewport().get_visible_rect().size * .5 #Pega o viewport e a area visivel dele

var posicao_atual #Posição atual aplicada no viewport
var historico_de_toque_x = [] #Array do eixo x
var historico_de_toque_y = [] #Array do eixo y
var foi_toque_realizado = false #Booleana para confirmar toque realizado

func _input(event):
	if event is InputEventScreenDrag: #Se o evento for um drag de input na tela
		posicao_atual = (event.get_position() - viewport_modificador) #Posição atual é igual a posição do evento - o tamanho total da tela

		if event.is_pressed():
			_atualizar_historico()
			emit_signal("toque_realizado", foi_toque_realizado)

		else:
			_atualizar_historico()
			emit_signal("toque_desfeito", foi_toque_realizado)

	if event is InputEventScreenTouch:
		if event.is_pressed():
			foi_toque_realizado = true
			emit_signal("toque_realizado", foi_toque_realizado)

		else:
			foi_toque_realizado = false
			emit_signal("toque_desfeito", foi_toque_realizado)

func _atualizar_historico():
	historico_de_toque_y.append(posicao_atual.y)
	historico_de_toque_x.append(posicao_atual.x)

	if len(historico_de_toque_x) > tamanho_array:
		historico_de_toque_x.pop_front()
	if len(historico_de_toque_y) > tamanho_array:
		historico_de_toque_y.pop_front()

	emit_signal("coordenadas_de_toque_x", historico_de_toque_x)
	emit_signal("coordenadas_de_toque_y", historico_de_toque_y)

#	$Label.text = "x=" + String(historico_de_toque_x) + " y=" + String(historico_de_toque_y)
