extends Node
class_name FabricaObstaculos

const OBSTACULO = preload ('res://recursos/jogos/enchente/componentes/Obstaculo.tscn')

var _tipos_de_obstaculos := {}
var _grupos := {}
var _obstaculos := {}
var _texturas := {}
var _tipo_sfx := {}
var _sons_obstaculos := {}
var _sfx := {}

func _init(tipos_de_obstaculos: Dictionary, tipo_sfx) -> void:
	_tipos_de_obstaculos = tipos_de_obstaculos
	_tipo_sfx = tipo_sfx
	for tipo in _tipos_de_obstaculos:
		_precarregar_texturas(tipo, _tipos_de_obstaculos[tipo].find('item') != -1)
	_precarregar_sfx()
	_listar_objetos()

func criar(id_obstaculo: String, posicao: Vector3) -> Obstaculo:
	var obstaculo := OBSTACULO.instance() as Obstaculo

	var informacoes_obstaculo = _informacoes_obstaculo(id_obstaculo)
	for grupo in informacoes_obstaculo['grupos']:
		obstaculo.add_to_group(grupo)
	if informacoes_obstaculo['item'] or informacoes_obstaculo['grupos'].has('rampa'):
		obstaculo.remove_from_group('obstaculo')

	obstaculo.info = informacoes_obstaculo
	obstaculo.position = posicao
	obstaculo.textura = _buscar_textura(informacoes_obstaculo)
	obstaculo.sfx = _sfx[informacoes_obstaculo['som']] if _sfx.has(informacoes_obstaculo['som']) else null

	return obstaculo

func _informacoes_obstaculo(id_obstaculo: String) -> Dictionary:
	var tipo = id_obstaculo.left(1)

	if int(tipo) == 8:
		assert(id_obstaculo.length() >= 2, 'Não é possível referenciar um item sem um tipo do item e id do item (8xy)')
		tipo = id_obstaculo.left(2)

	assert(_tipos_de_obstaculos.has(tipo), 'Tipo de obstaculo inexistente')

	if id_obstaculo == tipo:
		id_obstaculo = _randomizar(tipo)

	var info = {
		"id": id_obstaculo,
		"tipo": tipo,
		"item": int(tipo) >= 80,
		"som": _identificar_som(id_obstaculo)
	}
	info['grupos'] = _identificar_grupos(info)

	return info

func _identificar_som(id: String) -> String:
	if _sons_obstaculos.has(id):
		return _sons_obstaculos[id]

	for tipo_som in _tipo_sfx:
		for obstaculo in _tipo_sfx[tipo_som]:
			_sons_obstaculos[str(obstaculo)] = tipo_som

	return _sons_obstaculos[id] if _sons_obstaculos.has(id) else null

func _randomizar(tipo: String) -> String:
	return _obstaculos[tipo].pick_random()


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
	var texturas = _texturas[obsctaculo_info['tipo']]
	if not texturas.has(obsctaculo_info['id']):
		assert(false, 'Nao existe textura para o obstaculo %s' % obsctaculo_info['id'])
		return null

	return texturas[obsctaculo_info['id']]

func _precarregar_texturas(tipo: String, item:= false) -> void:
	if not _texturas.has(tipo):
		_texturas[tipo] = {}

	var caminho := 'res://elementos/imagem/enchente/obstaculos/%s' % tipo as String
	if item:
		caminho = 'res://elementos/imagem/enchente/itens/'

	var diretorio_texturas = Directory.new()
	if diretorio_texturas.open(caminho) != OK:
		pass

	diretorio_texturas.list_dir_begin(true, true)
	var nome_arquivo: String = diretorio_texturas.get_next()
	while nome_arquivo != "":
		var id = nome_arquivo.left(nome_arquivo.find('-'))
		# Workaround para ignorar a extensão .import ao listar o diretorio de texturas
		if nome_arquivo.ends_with('.import'):
			nome_arquivo = nome_arquivo.replace('.import', '')

		if nome_arquivo.get_extension() in ['png', 'jpg', 'webp']:
			# Exemplo: .../obstaculos/1/10-saco-lixo.png
			_texturas[tipo][id] = load('%s/%s' % [caminho, nome_arquivo])
		nome_arquivo = diretorio_texturas.get_next()
	diretorio_texturas.list_dir_end()

func _precarregar_sfx() -> void:
	_sfx =  {
		'carro':preload('res://elementos/audio/sfx/minigame-1/minigame1-dano-carro.mp3'),
		'entulho':preload('res://elementos/audio/sfx/minigame-1/minigame1-dano-entulho.mp3'),
		'onibus':preload('res://elementos/audio/sfx/minigame-1/minigame1-dano-onibus.mp3'),
		'placa':preload('res://elementos/audio/sfx/minigame-1/minigame1-dano-placa.mp3'),
		'pomba':preload('res://elementos/audio/sfx/minigame-1/minigame1-dano-pomba.mp3'),
		'poste':preload('res://elementos/audio/sfx/minigame-1/minigame1-dano-poste.mp3'),
		'semaforo':preload('res://elementos/audio/sfx/minigame-1/minigame1-dano-semaforo.mp3'),
		'coletavel':preload('res://elementos/audio/sfx/itens/coletavel-bandeira.mp3'),
		'vida':preload('res://elementos/audio/sfx/itens/coletavel-toalha.mp3'),
	}

func _listar_objetos():
	for tipo in _texturas:
		_obstaculos[tipo] = []
		for id in _texturas[tipo]:
			_obstaculos[tipo].append(id)
