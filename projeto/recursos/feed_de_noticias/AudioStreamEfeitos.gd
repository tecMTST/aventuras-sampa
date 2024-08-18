extends AudioStreamPlayer

#Array de Clipes de Audio:
onready var clipesSFX = {
	"clique": preload ("res://elementos/audio/sfx/hub/hub-clique.wav"),
	}

var _volume_atual = 999;

func _ready():
	stream_paused = true
	SingletonOpcoesGlobais.connect("Atualizou", self, "_atualizar_volume")

#Gatilhos de clique no botão:
func _on_coracaobotao_pressed():
	stop()
	stream = clipesSFX.clique
	play()

func _on_SaibaMais_pressed():
	stop()
	stream = clipesSFX.clique
	play()

func _on_SaibaMenos_pressed():
	stop()
	stream = clipesSFX.clique
	play()

func _on_Jogar_pressed():
	stop()
	stream = clipesSFX.clique
	play()

func _atualizar_volume():
	if SingletonOpcoesGlobais.volumeSFX != _volume_atual:
		_volume_atual = SingletonOpcoesGlobais.volumeSFX
		if _volume_atual == 0:
			stream_paused = true
		else:
			stream_paused = false
			volume_db = range_lerp (_volume_atual, 1, 100, -30, 0)
