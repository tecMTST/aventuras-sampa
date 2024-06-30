class_name ControladorDeObstaculos
extends Position3D

const OBSTACULO = preload('res://recursos/jogos/enchente/componentes/Obstaculo.tscn')

export var intervalo_obstaculos = 3.0
export var velocidade = 1000.0
export(NodePath) var faixas

onready var _timer = $TimerObstaculos
onready var _sorteador = $SorteadorDeEpisodios
onready var pontos_de_origem = get_node(faixas).get_children()

func _ready():
	_timer.connect('timeout', self, '_on_TimerObstaculos_timeout')
	_timer.wait_time = intervalo_obstaculos
	_timer.start()

func _on_TimerObstaculos_timeout() -> void:
	var modulo = _sorteador.sortear_modulo()

	assert(modulo.size() > 0, 'O modulo deve ter pelo menos uma linha')
	assert(modulo[0].size() == pontos_de_origem.size(), 'O tamanho dos pontos de origem deve ser o mesmo de obstaculos por linha')

	var contador_linha = 0
	for linha in modulo:
		contador_linha += 1
		for obstaculo_indice in range(linha.size()):
			var obstaculo = linha[obstaculo_indice]
			if obstaculo == 0:
				pass
			else:
				var ponto_de_origem: Position3D = pontos_de_origem[obstaculo_indice]
				var obstaculo_criado = OBSTACULO.instance()
				obstaculo_criado.velocidade = velocidade
				obstaculo_criado.transform.origin = Vector3(
					ponto_de_origem.transform.origin.x,
					ponto_de_origem.transform.origin.y,
					contador_linha * 10
				)
				add_child(obstaculo_criado)
