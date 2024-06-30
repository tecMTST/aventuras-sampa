extends AudioStreamPlayer

#Array de Clipes de Audio:
onready var clipesSFX = {
	"clique": preload ("res://elementos/audio/sfx/hub/hub-clique.wav"),
	}

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
