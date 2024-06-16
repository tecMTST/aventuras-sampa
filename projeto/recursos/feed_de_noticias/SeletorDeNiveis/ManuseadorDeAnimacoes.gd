extends Node

onready var animacao_coracao: AnimationPlayer = $AnimationPlayer2
onready var animacao_painel: AnimationPlayer = $AnimationPlayer

var coracao_apertado: bool = false
var saiba_mais_apertado: bool = false
var saiba_menos_apertado: bool = false

func _tocar_animacao_coracao():
	if coracao_apertado == false:
		animacao_coracao.play("Animação")
		yield(animacao_coracao, "animation_finished")
		coracao_apertado = true
	else:
		animacao_coracao.play_backwards("Animação")
		yield(animacao_coracao, "animation_finished")
		coracao_apertado = false

func _tocar_animacao_saiba_mais():
	if saiba_mais_apertado:
		animacao_painel.play("Transicao")
	elif saiba_mais_apertado == false and saiba_menos_apertado:
		animacao_painel.play_backwards("Transicao")


func _on_coracaobotao_pressed():
	_tocar_animacao_coracao()

func _on_SaibaMais_pressed():
	saiba_mais_apertado = true
	_tocar_animacao_saiba_mais()
	yield(animacao_painel, "animation_finished")
	saiba_mais_apertado = false

func _on_SaibaMenos_pressed():
	saiba_menos_apertado = true
	_tocar_animacao_saiba_mais()
	yield(animacao_painel, "animation_finished")
	saiba_menos_apertado = false
