extends Node

var volumeSom = 100
var volumeSFX = 100
var ativarBotoes: bool
#var ativarSpeedrun = false
#var tempoRecord = []
var dificuldadeAtual = "facil"

func _ready():
	FuncGlobais.carregar_globais()
	get_parent().PAUSE_MODE_PROCESS
