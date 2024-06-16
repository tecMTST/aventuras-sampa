extends AudioStreamPlayer

func _on_ControleFaixa3D_iniciou_movimento(_direcao, _alvo) -> void:
	stop()
	play()


func _on_ControleFaixa3D_terminou_movimento() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	stop()
