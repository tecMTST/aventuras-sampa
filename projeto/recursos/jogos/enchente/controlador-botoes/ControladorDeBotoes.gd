extends Node2D


signal botao_pressionado(acao)


func _on_direita_pressed():
	emit_signal("botao_pressionado", 'direita')


func _on_esquerda_pressed():
	emit_signal("botao_pressionado", 'esquerda')


func _on_acao_pressed():
	emit_signal("botao_pressionado", 'acao')
