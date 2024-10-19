extends Node

var volumeSom := 100.0
var volumeSFX := 100.0
var ativarBotoes: bool
#var ativarSpeedrun = false
#var tempoRecord = []
var dificuldadeAtual = "facil"
var pularCutScene : bool = false
var pularTutorial : bool = false

signal Atualizou

func _ready():
	carregar_globais()
	get_parent().PAUSE_MODE_PROCESS

func salvar_globais():
	Salvamento.salvar("globais", "volumeSom", volumeSom)
	_atualizar_volume_canal_som("BGM", volumeSom)
	Salvamento.salvar("globais", "volumeSFX", volumeSFX)
	_atualizar_volume_canal_som("SFX", volumeSFX)
	Salvamento.salvar("globais", "ativarBotoes", ativarBotoes)
	Salvamento.salvar("globais", "dificuldadeAtual", dificuldadeAtual)
	Salvamento.salvar("globais", "pularCutScene", pularCutScene)
	Salvamento.salvar("globais", "pularTutorial", pularTutorial)
	emit_signal("Atualizou")

func carregar_globais():
	if Salvamento.existe("globais", "volumeSom"):
		volumeSom = int(Salvamento.carregar("globais", "volumeSom"))
		_atualizar_volume_canal_som("BGM", volumeSom)
		volumeSFX = int(Salvamento.carregar("globais", "volumeSFX"))
		_atualizar_volume_canal_som("SFX", volumeSFX)
		ativarBotoes = bool(Salvamento.carregar("globais", "ativarBotoes"))
		dificuldadeAtual = str(Salvamento.carregar("globais", "dificuldadeAtual"))
		if Salvamento.carregar("globais", "pularCutScene"):			
			pularCutScene = bool(Salvamento.carregar("globais", "pularCutScene"))
		else:
			pularCutScene = false
		if Salvamento.carregar("globais", "pularTutorial"):			
			pularTutorial = bool(Salvamento.carregar("globais", "pularTutorial"))
		else:
			pularTutorial = false
	else:
		salvar_globais()

func _atualizar_volume_canal_som(canal: String, valor: float):
	var volume = lerp(-10.0, 1.0, valor/100)
	var canal_index = AudioServer.get_bus_index(canal)
	AudioServer.set_bus_volume_db(canal_index, volume)
	AudioServer.set_bus_mute(canal_index, valor < 0.01)
