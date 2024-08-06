extends Control


onready var audio_stream_bgm = $AudioStreamBGM

var _volume_atual = 999

func _process(delta):
	_check_volume()

func _check_volume():
	if SingletonOpcoesGlobais.volumeSom != _volume_atual:
		_volume_atual = SingletonOpcoesGlobais.volumeSom
		if _volume_atual == 0:				
			audio_stream_bgm.stream_paused = true			
		else:
			audio_stream_bgm.stream_paused = false			
			audio_stream_bgm.volume_db = FuncGlobais.map(_volume_atual, 1, 100, -30, 0)		
