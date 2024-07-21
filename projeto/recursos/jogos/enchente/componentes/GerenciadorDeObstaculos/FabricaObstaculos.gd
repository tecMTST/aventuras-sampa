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

	var informacoes_obstaculo = _informacoes_obstaculo(id_obstaculo)
	for grupo in informacoes_obstaculo['grupos']:
		obstaculo.add_to_group(grupo)
	if informacoes_obstaculo['item'] or informacoes_obstaculo['grupos'].has('rampa'):
		obstaculo.remove_from_group('obstaculo')

	obstaculo.position = posicao
	obstaculo.textura = _buscar_textura(informacoes_obstaculo)

	return obstaculo

func _informacoes_obstaculo(id_obstaculo: String) -> Dictionary:
	var tipo = id_obstaculo.left(1)

	if int(tipo) == 8:
		assert(id_obstaculo.length() >= 2, 'Não é possível referenciar um item sem um tipo do item e id do item (8xy)')
		assert(_tipos_de_itens.has(id_obstaculo[1]), 'Tipo de item inexistente')
		tipo = id_obstaculo.left(2)

	assert(_tipos_de_obstaculos.has(tipo), 'Tipo de obstaculo inexistente')

	var info = {
		"id": id_obstaculo,
		"tipo": tipo,
		"item": int(tipo) >= 80,
	}

	info['grupos'] = _identificar_grupos(info)

	return info

func _identificar_grupos(info: Dictionary) -> PoolStringArray:
	if _grupos.has(info['id']):
		return _grupos.get(info['id'])

	var grupos := PoolStringArray()
	var grupo = _tipos_de_obstaculos.get(info['tipo'])
	# Garante que itens e obstaculos sejam categoriazados pelos seu subtipo
	if '-' in grupo:
		for g in grupo.split('-'):
			grupos.append(g)
	else:
		grupos.append(grupo)

	_grupos[info['id']] = grupos
	print('Grupos do obstaculo %s: %s' % [info['id'], grupos])
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
		# Garante que texturas de itens tenham somente imagens que correspondam ao tipo de item
		if obsctaculo_info['item'] and not id.begins_with(obsctaculo_info['tipo']):
			nome_arquivo = diretorio_texturas.get_next()
			continue

		# Workaround para ignorar a extensão .import ao listar o diretorio de texturas
		if nome_arquivo.ends_with('.import'):
			nome_arquivo = nome_arquivo.replace('.import', '')

		if nome_arquivo.get_extension() in ['png', 'jpg', 'webp']:
			# Exemplo: .../obstaculos/1/10-saco-lixo.png
			texturas_carregadas[id] = load('%s/%s' % [caminho, nome_arquivo])
		nome_arquivo = diretorio_texturas.get_next()
	diretorio_texturas.list_dir_end()

	return texturas_carregadas
