extends Node
class_name MenuOpcoes

onready var SingletonGlobal = SingletonOpcoesGlobais
onready var menu: TextureRect = $MenuDeOpcoes/Menu
onready var musicaWheel: HSlider = $MenuDeOpcoes/Menu/VolumeMusica
onready var efeitosWheel: HSlider = $MenuDeOpcoes/Menu/VolumeEfeitos
onready var porcentagemMusicaWheel: Label = $MenuDeOpcoes/Menu/VolumeMusica/Porcentagem
onready var porcentagemEfeitosWheel: Label = $MenuDeOpcoes/Menu/VolumeEfeitos/Porcentagem
onready var voltar: TextureButton = $MenuDeOpcoes/Menu/VoltarJogar
onready var menuFeed: TextureButton = $MenuDeOpcoes/Menu/VoltarMenuFeed
onready var controles: TextureButton = $MenuDeOpcoes/Menu/Controles
onready var facil: TextureButton = $MenuDeOpcoes/Menu/facil
onready var medio: TextureButton = $MenuDeOpcoes/Menu/medio
onready var dificil: TextureButton = $MenuDeOpcoes/Menu/dificil

export var voltarJogo: String = ''

func _ready():
	get_tree().paused = true
	facil.connect('pressed',self,"_botao_dificuldade",[facil])
	medio.connect('pressed',self,"_botao_dificuldade",[medio])
	dificil.connect('pressed',self,"_botao_dificuldade",[dificil])
	controles.connect('toggled',self,"_mudar_controles")
	_definir_valores()

func _definir_valores():
	musicaWheel.value = SingletonGlobal.volumeSom
	efeitosWheel.value = SingletonGlobal.volumeSFX
	self[SingletonGlobal.dificuldadeAtual].pressed = true

func _input(event):
	var valorMusicaGlobal = musicaWheel.value
	var valorSfxGlobal = efeitosWheel.value
	if event is InputEventScreenTouch:
		#envia para o singleton o valor de som e de musica
		SingletonGlobal.volumeSom = valorMusicaGlobal
		SingletonGlobal.volumeSFX = valorSfxGlobal
		SingletonOpcoesGlobais.salvar_globais()

func _on_VoltarJogar_button_up():
	get_tree().paused = false
	self.queue_free()

func _on_VoltarMenuFeed_button_up():
	get_tree().paused = false
	TrocadorDeCenas.trocar_cena(voltarJogo)
	self.queue_free()

func _mudar_controles(alteracao: bool):
	SingletonGlobal.ativarBotoes = alteracao
	SingletonOpcoesGlobais.salvar_globais()

func _botao_dificuldade(dificuldadeAtual):
	if not dificuldadeAtual:
		pass
	SingletonOpcoesGlobais.dificuldadeAtual = dificuldadeAtual.name
	SingletonOpcoesGlobais.salvar_globais()

	var botoes := [facil,medio,dificil]
	botoes.erase(dificuldadeAtual)
	for botao in botoes:
		botao.pressed = false

func _process(delta):
	porcentagemMusicaWheel.text = str(musicaWheel.value) + '%'
	porcentagemEfeitosWheel.text = str(efeitosWheel.value) + '%'
	controles.pressed = SingletonGlobal.ativarBotoes
