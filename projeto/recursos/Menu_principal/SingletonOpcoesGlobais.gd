extends Node

var volumeSom = 100
var volumeSFX = 100
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
	Salvamento.salvar("globais", "volumeSFX", volumeSFX)
	Salvamento.salvar("globais", "ativarBotoes", ativarBotoes)
	Salvamento.salvar("globais", "dificuldadeAtual", dificuldadeAtual)
	Salvamento.salvar("globais", "pularCutScene", pularCutScene)
	Salvamento.salvar("globais", "pularTutorial", pularTutorial)
	emit_signal("Atualizou")

func carregar_globais():
	if Salvamento.existe("globais", "volumeSom"):
		volumeSom = int(Salvamento.carregar("globais", "volumeSom"))
		volumeSFX = int(Salvamento.carregar("globais", "volumeSFX"))
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
