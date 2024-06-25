extends AudioStreamPlayer

onready var sons = {
	"agua": preload ("res://elementos/som/movimento_agua.wav"),
	"dano": preload ("res://elementos/som/bolha_2.wav")
	}

func _on_ControleFaixa3D_iniciou_movimento(_direcao, _alvo) -> void:
	stop()
	stream = sons.agua
	play()


func _on_ControleFaixa3D_terminou_movimento() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	stop()

func _on_Vida_vida_alterada(alteracao: Vida.VidaAlterada) -> void:
	if !alteracao.cura:
		stop()
		stream = sons.dano
		play()
