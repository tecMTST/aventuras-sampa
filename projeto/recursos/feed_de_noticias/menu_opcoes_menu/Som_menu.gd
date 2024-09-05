extends Control

onready var audio_stream_bgm = $AudioStreamBGM

var _volume_atual = 999

func _ready():
	SingletonOpcoesGlobais.connect("Atualizou", self, "_atualizar_volume")
	_atualizar_volume()

func _atualizar_volume():
	if SingletonOpcoesGlobais.volumeSom != _volume_atual:
		_volume_atual = SingletonOpcoesGlobais.volumeSom
		if _volume_atual == 0:
			audio_stream_bgm.stream_paused = true
		else:
			audio_stream_bgm.stream_paused = false
			audio_stream_bgm.volume_db = range_lerp(_volume_atual, 1, 100, -30, 0)
