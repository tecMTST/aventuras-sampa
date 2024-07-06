class_name ControladorDeObstaculos
extends Position3D

const OBSTACULO = preload ('res://recursos/jogos/enchente/componentes/Obstaculo.tscn')

export var intervalo_modulos := 3.0
export var distancia_obstaculos := 10.0
export(NodePath) var faixas
export(NodePath) var tempo

onready var _tempo := get_node(tempo) as Timer
onready var _sorteador = $SorteadorDeEpisodios
onready var _pontos_de_origem := get_node(faixas).get_children()
onready var _numero_modulos = 0
onready var _intervalo_adicionar_modulos := $Timer

func _ready() -> void:
	_intervalo_adicionar_modulos.connect('timeout', self, 'adicionar_modulo')


func adicionar_modulo() -> void:
	var modulo = _sorteador.sortear_modulo(_tempo.wait_time - _tempo.time_left)

	assert(modulo.size() > 0, 'O modulo deve ter pelo menos uma linha')
	assert(modulo[0].size() == _pontos_de_origem.size(), 'O tamanho dos pontos de origem deve ser o mesmo de obstaculos por linha')

	var contador_linha = 0
	for linha in modulo:
		contador_linha += 1
		for obstaculo_indice in range(linha.size()):
			var tipo_obstaculo = linha[obstaculo_indice]
			if tipo_obstaculo != 0:
				var obstaculo_criado = OBSTACULO.instance() # A instanciação pode ser substituida pela Fábrica de Obstaculos
				obstaculo_criado.velocidade = self._calcular_fator_velocidade(obstaculo_criado)
				obstaculo_criado.transform.origin = self._posicao_do_obstaculo(obstaculo_indice, contador_linha)
				add_child(obstaculo_criado)
	_numero_modulos += 1


func _posicao_do_obstaculo(obstaculo_indice: int, contador_linha: int) -> Vector3:
	var ponto_de_origem: Position3D = _pontos_de_origem[obstaculo_indice]
	return Vector3(
		ponto_de_origem.transform.origin.x,
		ponto_de_origem.transform.origin.y,
		position.z + (contador_linha * distancia_obstaculos)
	)


func _calcular_fator_velocidade(obstaculo) -> float:
	return obstaculo.velocidade * EnchenteEstadoDeJogo.VelocidadeGlobal
