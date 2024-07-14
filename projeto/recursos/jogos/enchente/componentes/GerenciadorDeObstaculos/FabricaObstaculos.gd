extends Node
class_name FabricaObstaculos

const OBSTACULO = preload ('res://recursos/jogos/enchente/componentes/Obstaculo.tscn')

var _tipos_de_obstaculo := {}
var _grupos := {}
var _texturas := {}

func _init(tipo_de_obstaculos: Dictionary) -> void:
	_tipos_de_obstaculo = tipo_de_obstaculos

func criar(id_obstaculo: String, posicao: Vector3) -> Obstaculo:
	var obstaculo := OBSTACULO.instance() as Obstaculo

	obstaculo.textura = _buscar_textura(id_obstaculo)
	obstaculo.position = posicao
	obstaculo.add_to_group(_identificar_grupo(id_obstaculo))

	return obstaculo

func _identificar_grupo(tipo: String) -> String:
	if _grupos.has(tipo):
		return _grupos.get(tipo)
	if _tipos_de_obstaculo.has(tipo):
		var grupo = _tipos_de_obstaculo.get(tipo)
		_grupos[tipo] = grupo
		return grupo

	var referencia = tipo.left(1)
	if not _tipos_de_obstaculo.has(referencia):
		_grupos[tipo] = 'generico'
		return 'generico'

	var grupo = _tipos_de_obstaculo.get(referencia)
	_grupos[tipo] = grupo
	return grupo

func _buscar_textura(id_obstaculo: String) -> Texture:
	var tipo = id_obstaculo.left(1)
	if not _texturas.has(tipo):
		_texturas[tipo] = _carregar_texturas(tipo)

	var texturas = _texturas[tipo]
	if tipo == id_obstaculo:
		return texturas.values().pick_random() as Texture

	if not texturas.has(id_obstaculo):
		assert(false, 'Nao existe textura para o obstaculo %s' % id_obstaculo)
		return null

	return texturas[id_obstaculo]

func _carregar_texturas(tipo: String) -> Dictionary:
	var texturas_carregadas = {}

	var caminho = 'res://elementos/imagem/enchente/obstaculos/%s' % tipo
	var diretorio_texturas = Directory.new()
	if diretorio_texturas.open(caminho) != OK:
		assert(false, 'Erro ao abrir o diretorio %s' % caminho)
		return texturas_carregadas

	diretorio_texturas.list_dir_begin(true, true)
	var nome_arquivo: String = diretorio_texturas.get_next()
	while nome_arquivo != "":
		var id = nome_arquivo.left(nome_arquivo.find('-'))
		if nome_arquivo.get_extension() in ['png', 'jpg', 'webp']:
			# Exemplo: .../obstaculos/1/10-saco-lixo.png
			texturas_carregadas[id] = load('%s/%s' % [caminho, nome_arquivo])
		nome_arquivo = diretorio_texturas.get_next()
	diretorio_texturas.list_dir_end()

	return texturas_carregadas
