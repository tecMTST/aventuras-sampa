class_name SorteadorDeEpisodios
extends Node


export var nome_arquivo_json: String = 'res://elementos/modulos.json'

var lista_modulos: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	lista_modulos = _ler_arquivo_json(nome_arquivo_json)['modulos']


func _ler_arquivo_json(nome: String) -> Dictionary:
	var arquivo = File.new()
	arquivo.open(nome_arquivo_json, File.READ)
	var texto = arquivo.get_as_text()
	print(texto)
	var conteudo = JSON.parse(texto)
	return conteudo.result

func resetar():
	pass

func sortear_modulo() -> Array:
	var modulo_sorteado = []
	return modulo_sorteado
