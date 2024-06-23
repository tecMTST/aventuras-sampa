extends Spatial

signal animacaoTerminou

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var timerDoTempoDeEspera: Timer = $TimerDoTempoDeEspera

export var tempoDeEsperaPrimeiraFase: int = 25 #em segundos
export var tempoDeEsperaSegundaFase: int = 25 #em segundos

var faseAtual: int = 0
var ativadoPorSinal: bool = false

func _ready():
	# se for ativado por um sinal não precisa criar um timer
	if ativadoPorSinal:
		_rodar_animacao()
		faseAtual += 1
		
	else:
		timerDoTempoDeEspera.start(tempoDeEsperaPrimeiraFase)
		yield(timerDoTempoDeEspera, "timeout")
		_rodar_animacao()
		yield(animationPlayer, "animation_finished")
		faseAtual += 1
		
		timerDoTempoDeEspera.start(tempoDeEsperaSegundaFase)
		yield(timerDoTempoDeEspera, "timeout")
		_rodar_animacao()
		yield(animationPlayer, "animation_finished")
		faseAtual += 1
		
	if faseAtual > 2:
		timerDoTempoDeEspera.stop()

func _rodar_animacao():
	if faseAtual == 0:
		animationPlayer.play("cidadesubindofase1")
		self.emit_signal("animacaoTerminou", true)

	elif faseAtual == 1:
		animationPlayer.play("cidadesubindofase2")
		self.emit_signal("animacaoTerminou", true)

	else:
		animationPlayer.play("cidadesubindofim")
