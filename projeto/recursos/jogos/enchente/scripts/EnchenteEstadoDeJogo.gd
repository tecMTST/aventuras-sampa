extends Node

var VelocidadeGlobal = 1.0
var TemporizadorGlobal := Timer.new()
var TempoAtual := 0.0

func _process(_delta: float) -> void:
	TempoAtual = TemporizadorGlobal.wait_time - TemporizadorGlobal.time_left

func definir_tempo_de_jogo(tempo: float) -> void:
	TemporizadorGlobal.wait_time = tempo

func iniciar_temporizador() -> void:
	TemporizadorGlobal.start()
