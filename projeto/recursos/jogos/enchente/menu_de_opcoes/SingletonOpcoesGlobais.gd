extends Node

var volumeSom = 0
var volumeSFX = 0
var ativarBotoes: bool
#var ativarSpeedrun = false
#var tempoRecord = []
var dificuldadeAtual = []

func _ready():
	get_parent().PAUSE_MODE_PROCESS
