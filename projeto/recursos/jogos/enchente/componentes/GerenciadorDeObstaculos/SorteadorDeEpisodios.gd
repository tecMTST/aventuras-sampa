class_name SorteadorDeEpisodios
extends Node


export var nome_arquivo_json: String = 'res://elementos/modulos.json'


func resetar():
	historico_de_modulos = []
	_modulos_selecionaveis = _lista_de_modulos.duplicate()


func sortear_modulo() -> Array:
	var modulo_sorteado = _modulo_aleatorio()
	_remover_grupo(modulo_sorteado['grupo'])
	historico_de_modulos.append(modulo_sorteado)
	return modulo_sorteado['obstaculos']


var historico_de_modulos = []

var _lista_de_modulos: Array
var _modulos_selecionaveis: Array = []
var _gna = RandomNumberGenerator.new()


func _ready():
	_lista_de_modulos = _ler_arquivo_json(nome_arquivo_json)['modulos']
	_modulos_selecionaveis = _lista_de_modulos.duplicate()


func _ler_arquivo_json(nome: String) -> Dictionary:
	var arquivo = File.new()
	arquivo.open(nome_arquivo_json, File.READ)
	var texto = arquivo.get_as_text()
	var conteudo = JSON.parse(texto)
	return conteudo.result


func _calcular_probabilidade_total() -> float:
	var prob_total: float = 0
	for modulo in _modulos_selecionaveis:
		prob_total += modulo['chance']
	return prob_total


func _modulo_aleatorio():
	var prob_total = _calcular_probabilidade_total()
	var prob = _gna.randf_range(0, prob_total)
	for modulo in _modulos_selecionaveis:
		if prob < modulo['chance']:
			return modulo
		prob -= modulo['chance']
	return _modulos_selecionaveis.pick_random()


func _remover_grupo(grupo: int):
	if grupo == 0:
		return
	var novos_modulos = []
	for i in _modulos_selecionaveis.size():
		var modulo = _modulos_selecionaveis[i]
		if modulo['grupo'] != grupo:
			novos_modulos.append(modulo)
	_modulos_selecionaveis = novos_modulos
