extends Node
class_name FabricaObstaculos

const OBSTACULO = preload ('res://recursos/jogos/enchente/componentes/Obstaculo.tscn')

var _tipos_de_obstaculos := {}
var _tipos_de_itens := {}
var _grupos := {}
var _texturas := {}

func _init(tipos_de_obstaculos: Dictionary, tipos_de_itens: Dictionary) -> void:
	_tipos_de_obstaculos = tipos_de_obstaculos
	_tipos_de_itens = tipos_de_itens

func criar(id_obstaculo: String, posicao: Vector3) -> Obstaculo:
	var obstaculo := OBSTACULO.instance() as Obstaculo

	var obsctaculo_info = {
		"id": id_obstaculo,
		"tipo": id_obstaculo.left(1),
		"item": false,
	}

	obsctaculo_info['grupos'] = _identificar_grupos(id_obstaculo)
	if obsctaculo_info['grupos'].find('item') != - 1:
		obsctaculo_info['item'] = true

	for grupo in obsctaculo_info['grupos']:
		obstaculo.add_to_group(grupo)

	obstaculo.position = posicao
	obstaculo.textura = _buscar_textura(obsctaculo_info)

	return obstaculo

func _identificar_grupos(id_obstaculo: String) -> PoolStringArray:
	if _grupos.has(id_obstaculo):
		return _grupos.get(id_obstaculo)

	var grupos := PoolStringArray()

	var referencia = id_obstaculo.left(1)
	if not _tipos_de_obstaculos.has(referencia):
		grupos.append('generico')
		_grupos[id_obstaculo] = grupos
		return grupos

	var grupo = _tipos_de_obstaculos.get(referencia)
	grupos.append(grupo)

	if grupo == 'item':
		print(id_obstaculo.length())
		assert(id_obstaculo.length() >= 2, 'Não é possível referenciar um item sem um tipo')
		var item = _tipos_de_itens.get(id_obstaculo[1])
		grupos.append(item)

	_grupos[id_obstaculo] = grupos
	return grupos

func _buscar_textura(obsctaculo_info: Dictionary) -> Texture:
	if not _texturas.has(obsctaculo_info['tipo']):
		_texturas[obsctaculo_info['tipo']] = _carregar_texturas(obsctaculo_info)

	var texturas = _texturas[obsctaculo_info['tipo']]
	if obsctaculo_info['tipo'] == obsctaculo_info['id']:
		return texturas.values().pick_random() as Texture

	if not texturas.has(obsctaculo_info['id']):
		assert(false, 'Nao existe textura para o obstaculo %s' % obsctaculo_info['id'])
		return null

	return texturas[obsctaculo_info['id']]

func _carregar_texturas(obsctaculo_info: Dictionary) -> Dictionary:
	var texturas_carregadas = {}

	var caminho := 'res://elementos/imagem/enchente/obstaculos/%s' % obsctaculo_info['tipo'] as String
	if obsctaculo_info['item']:
		caminho = 'res://elementos/imagem/enchente/itens/'
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
