extends Spatial

signal animacaoTerminou

onready var timerDoTempoDeEspera: Timer = $TimerDoTempoDeEspera

export var tempoDeEsperaPrimeiraFase: int = 25 #em segundos
export var tempoDeEsperaSegundaFase: int = 25 #em segundos

var faseAtual: int = 0
var ativadoPorSinal: bool = false

func _ready() -> void:
	pass
