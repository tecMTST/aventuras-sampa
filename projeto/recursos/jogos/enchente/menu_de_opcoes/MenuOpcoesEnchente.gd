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
	print(SingletonGlobal.ativarBotoes)
	get_tree().paused = true

	musicaWheel.value = SingletonGlobal.volumeSom
	porcentagemMusicaWheel.text = str(musicaWheel.value) + '%'

	efeitosWheel.value = SingletonGlobal.volumeSFX
	porcentagemEfeitosWheel.text = str(efeitosWheel.value) + '%'
	
	_mudar_controles()
	botao_dificuldade(SingletonOpcoesGlobais.dificuldadeAtual)

func _input(event):
	var valorMusicaGlobal = musicaWheel.value
	var valorSfxGlobal = efeitosWheel.value
	var controlesForamApertado = controles.pressed
	if event is InputEventScreenTouch:
		#envia para o singleton o valor de som e de musica
		SingletonGlobal.volumeSom = valorMusicaGlobal
		SingletonGlobal.volumeSFX = valorSfxGlobal
		#envia para o singleton o se o botao foi apertado ou não
		if controlesForamApertado == false:
			SingletonGlobal.ativarBotoes = false
		elif controlesForamApertado == true:
			SingletonGlobal.ativarBotoes = true

		if facil.pressed and !medio.pressed and !dificil.pressed:
			botao_dificuldade('facil')
		elif !facil.pressed and medio.pressed and !dificil.pressed:
			botao_dificuldade('medio')
		elif !facil.pressed and !medio.pressed and dificil.pressed:
			botao_dificuldade('dificil')
		elif facil.pressed and medio.pressed and dificil.pressed:
			$MenuDeOpcoes/Menu/DificuldadePressionada.visible = false
			facil.pressed = false
			medio.pressed = false
			dificil.pressed = false
		else:
			facil.pressed = false
			medio.pressed = false
			dificil.pressed = false
			
		SingletonOpcoesGlobais.salvar_globais()			

func _on_VoltarJogar_button_up():
	get_tree().paused = false
	self.queue_free()

func _on_VoltarMenuFeed_button_up():
	get_tree().paused = false
	TrocadorDeCenas.trocar_cena(voltarJogo)
	self.queue_free()

func _mudar_controles():
	if SingletonGlobal.ativarBotoes == true:
		controles.pressed = true
	if SingletonGlobal.ativarBotoes == false:
		controles.pressed = false
	SingletonOpcoesGlobais.salvar_globais()

func botao_dificuldade(botaoPressionado):
	var botaoAtual = botaoPressionado
	match botaoAtual:
		'facil':
			SingletonOpcoesGlobais.dificuldadeAtual = 'facil'
			$MenuDeOpcoes/Menu/DificuldadePressionada.visible = true
			$MenuDeOpcoes/Menu/DificuldadePressionada.rect_position.x = facil.rect_position.x			
		'medio':
			SingletonOpcoesGlobais.dificuldadeAtual = 'medio'
			$MenuDeOpcoes/Menu/DificuldadePressionada.visible = true
			$MenuDeOpcoes/Menu/DificuldadePressionada.rect_position.x = medio.rect_position.x
		'dificil':
			SingletonOpcoesGlobais.dificuldadeAtual = 'dificil'
			$MenuDeOpcoes/Menu/DificuldadePressionada.visible = true
			$MenuDeOpcoes/Menu/DificuldadePressionada.rect_position.x = dificil.rect_position.x
	SingletonOpcoesGlobais.salvar_globais()
	
func _process(delta):
	porcentagemMusicaWheel.text = str(musicaWheel.value) + '%'
	porcentagemEfeitosWheel.text = str(efeitosWheel.value) + '%'
	
