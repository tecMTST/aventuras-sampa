extends Control

signal transicao_saida_concluida
signal cena_removida
signal cena_carregada
signal transicao_entrada_concluida

const OPCOES_PADRAO := {
	"cor_de_fundo": Color("#000000"),
	"tempo_espera_transicao": 0.5,
	"velocidade_transicao": 2,
	"pular_transicao_saida": false,
	"transicao_saida": "fade",
	# "padrao_transicao_saida": null,
	"realizar_troca_de_cena": true,
	"pular_transicao_entrada": false,
	"transicao_entrada": "fade",
	# "padrao_transicao_entrada": null,
	"inverter": false,
}

var em_transicao := false

onready var _arvore_cenas := get_tree()
onready var _cena_raiz := _arvore_cenas.get_root()
onready var _cena_atual := _arvore_cenas.current_scene
onready var _cena_anterior: Node = null
onready var _tocador_animacao: AnimationPlayer = $Animacao
onready var _fundo: ColorRect = $Tela/Fundo

func _ready() -> void:
	assert(_fundo.material is ShaderMaterial, "O fundo deve ter material de shader.")
	call_deferred("emit_signal", "cena_carregada")

func _process(delta: float) -> void:
	if not is_instance_valid(_cena_anterior) and _arvore_cenas.current_scene:
		_cena_anterior = _arvore_cenas.current_scene
		_cena_atual = _arvore_cenas.current_scene
		emit_signal("cena_carregada")
	if _arvore_cenas.current_scene != _cena_anterior:
		_cena_anterior = _arvore_cenas.current_scene

func _carregar_recurso(recurso) -> Resource:
	if recurso is PackedScene:
		return recurso
	return ResourceLoader.load(recurso)

func _carregar_transicao(padrao_transicao) -> Texture:
	assert(
		padrao_transicao is Texture or padrao_transicao is String,
		"O padrão %s não é um Texture, caminho absoluto, ou transição pré-construida." % padrao_transicao
	)

	if padrao_transicao is String:
		if padrao_transicao.is_abs_path():
			return _carregar_recurso(padrao_transicao) as Texture
		elif padrao_transicao == "fade":
			return null
		return _carregar_recurso("res://addons/trocador_de_cenas/padroes_transicao/%s.png" % padrao_transicao) as Texture
	return padrao_transicao

func _preparar_opcoes(opcoes_recebidas: Dictionary) -> Dictionary:
	var opcoes := opcoes_recebidas.duplicate()
	for indice in OPCOES_PADRAO:
		if not indice in opcoes:
			opcoes[indice] = OPCOES_PADRAO[indice]

	for transicao in ["transicao_saida", "transicao_entrada"]:
		opcoes["padrao_%s" % transicao] = _carregar_transicao(opcoes[transicao])

	return opcoes

func transicao_saida(opcoes_recebidas: Dictionary={}) -> void:
	var opcoes = _preparar_opcoes(opcoes_recebidas)
	em_transicao = true
	_tocador_animacao.playback_speed = opcoes["velocidade_transicao"]
	_fundo.material.set_shader_param("dissolve_texture", opcoes["padrao_transicao_saida"])
	_fundo.material.set_shader_param("fade", not opcoes["padrao_transicao_saida"])
	_fundo.material.set_shader_param("fade_color", opcoes["cor_de_fundo"])
	_fundo.material.set_shader_param("inverted", opcoes["inverter"])
	_tocador_animacao.play("animar_shader")
	yield (_tocador_animacao, "animation_finished")
	emit_signal("transicao_saida_concluida")

func transicao_entrada(opcoes_recebidas: Dictionary={}) -> void:
	var opcoes = _preparar_opcoes(opcoes_recebidas)
	_tocador_animacao.playback_speed = opcoes["velocidade_transicao"]
	_fundo.material.set_shader_param("dissolve_texture", opcoes["padrao_transicao_entrada"])
	_fundo.material.set_shader_param("fade", not opcoes["padrao_transicao_entrada"])
	_fundo.material.set_shader_param("fade_color", opcoes["cor_de_fundo"])
	_fundo.material.set_shader_param("inverted", opcoes["inverter"])
	_tocador_animacao.play_backwards("animar_shader")
	yield (_tocador_animacao, "animation_finished")
	em_transicao = false
	emit_signal("transicao_entrada_concluida")

func _trocar_cena(cena: String) -> void:
	_cena_atual.queue_free()
	emit_signal("cena_removida")
	var proxima_cena = _carregar_recurso(cena) as PackedScene
	_cena_atual = proxima_cena.instance()
	yield (_arvore_cenas.create_timer(0.0), "timeout")
	_cena_raiz.add_child(_cena_atual)
	_arvore_cenas.set_current_scene(_cena_atual)

func trocar_cena(cena: String, opcoes_recebidas: Dictionary={}) -> void:
	var opcoes = _preparar_opcoes(opcoes_recebidas)
	if not opcoes["pular_transicao_saida"]:
		yield (transicao_saida(opcoes), "completed")
	if opcoes["realizar_troca_de_cena"]:
		_trocar_cena(cena)
	yield (_arvore_cenas.create_timer(opcoes["tempo_espera_transicao"]), "timeout")
	if not opcoes["pular_transicao_entrada"]:
		yield (transicao_entrada(opcoes), "completed")
