extends CanvasLayer

onready var SingletonGlobal = SingletonOpcoesGlobais
onready var menu: TextureRect = $MenuDeOpcoes/Menu
onready var musicaWheel: HSlider = $MenuDeOpcoes/Menu/VolumeMusica
onready var efeitosWheel: HSlider = $MenuDeOpcoes/Menu/VolumeEfeitos
onready var porcentagemMusicaWheel: Label = $MenuDeOpcoes/Menu/Porcentagem
onready var porcentagemEfeitosWheel: Label = $MenuDeOpcoes/Menu/Porcentagem2
onready var voltarmenu: TextureButton = $MenuDeOpcoes/Menu/VoltarMenu
onready var voltarjogo: TextureButton = $MenuDeOpcoes/Menu/VoltarJogo

export var menupath: String = 'res://recursos/Menu_principal/Menu_Principal.tscn'

func _ready():
	print(SingletonGlobal.ativarBotoes)
	get_tree().paused = true

	musicaWheel.value = SingletonGlobal.volumeSom
	porcentagemMusicaWheel.text = str(musicaWheel.value) + '%'

	efeitosWheel.value = SingletonGlobal.volumeSFX
	porcentagemEfeitosWheel.text = str(efeitosWheel.value) + '%'

	if get_tree().get_current_scene().get_name() == "Enchente":
		#print(get_tree().get_current_scene().get_name())
		pass
	else:
		voltarmenu.visible = false
		$MenuDeOpcoes/Menu/VoltarJogo/Label.text = "voltar ao menu"
		#print(get_tree().get_current_scene().get_name())

func _input(event):
	var valorMusicaGlobal = musicaWheel.value
	var valorSfxGlobal = efeitosWheel.value
	if event is InputEventScreenTouch:
		#envia para o singleton o valor de som e de musica
		SingletonGlobal.volumeSom = valorMusicaGlobal
		SingletonGlobal.volumeSFX = valorSfxGlobal
		SingletonOpcoesGlobais.salvar_globais()

func _on_VoltarJogo_button_up():
	get_tree().paused = false
	self.queue_free()

func _on_VoltarMenu_button_up():
	get_tree().paused = false
	TrocadorDeCenas.trocar_cena(menupath)
	self.queue_free()

func _process(delta):
	porcentagemMusicaWheel.text = str(musicaWheel.value) + '%'
	porcentagemEfeitosWheel.text = str(efeitosWheel.value) + '%'
