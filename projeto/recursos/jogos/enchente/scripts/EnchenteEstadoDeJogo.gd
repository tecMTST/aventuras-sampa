extends Node

signal iniciou()
signal trocou_fase(fase)

var VelocidadeGlobal = 1.0
var TemporizadorGlobal := Timer.new()
var TempoAtual := 0.0
var fase := 1

func _process(_delta: float) -> void:
	TempoAtual = TemporizadorGlobal.wait_time - TemporizadorGlobal.time_left
	var checar_fase = int(TempoAtual / 60) + 1  # verificar outra forma de fazer isso
	if checar_fase > fase:
		fase = checar_fase
		emit_signal('trocou_fase',fase)


func definir_tempo_de_jogo(tempo: float) -> void:
	TemporizadorGlobal.wait_time = tempo

func iniciar_temporizador() -> void:
	TemporizadorGlobal.start()
	emit_signal('iniciou')
