extends Node

signal toque_realizado(historico) #toque realizado
signal toque_desfeito(historico) #toque desfeito
signal arrastar_realizado(historico) #tela arrastada

export var tamanho_array = 2 #Tamanho total que a array pode chegar

onready var viewport_modificador = get_viewport().get_visible_rect().size * .5 #Pega o viewport e a area visivel dele

var posicao_atual: Vector2 #Posição atual aplicada no viewport
var historico: PoolVector2Array = []

func _input(event):
	if event is InputEventScreenDrag: #Se o evento for um drag de input na tela
		posicao_atual = (event.get_position() - viewport_modificador) #Posição atual é igual a posição do evento - o tamanho total da tela

		_atualizar_historico()
		emit_signal("arrastar_realizado", historico)

	if event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("toque_realizado", historico)

		else:
			emit_signal("toque_desfeito", historico)
			historico = []

func _atualizar_historico():
	historico.append(posicao_atual)
	if len(historico) > tamanho_array:
		historico.remove(0)

