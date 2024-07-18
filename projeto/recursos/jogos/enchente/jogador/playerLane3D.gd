extends KinematicBody
class_name PlayerLane3D

export var tempo_imunidade_dano : float = 3.0

onready var controle_faixa_3d = $ControleFaixa3D
onready var vida = $Vida as Vida
onready var sprite = $Sprite as AnimatedSprite3D
onready var timer_imunidade = $TimerImunidade
onready var imunidade_modulate = false
onready var menuOpcoes = preload("res://recursos/jogos/enchente/menu_de_opcoes/MenuDeOpcoes.tscn")

var imune = false
var imune_dano = false
var imunidade_time : float = 0

func _input(event):
	if Input.is_action_just_pressed("pause"):
		pause()

func _on_ControladorArrasta_arrastado(chave):
	if chave=='direita':
		controle_faixa_3d.mover_direita()
		print('a')
	elif chave=='esquerda-0' or chave=='esquerda-1':
		controle_faixa_3d.mover_esquerda()

func _on_AreaDano_body_entered(body: Node) -> void:
	if body.is_in_group("obstaculo") and not imune:
		vida.receber_dano(1.0)
		imunidade(true, tempo_imunidade_dano)
	if body.is_in_group("powerup") and not imune:
		imunidade(false, tempo_imunidade_dano)
	if body.is_in_group("rampa") and not imune:
		controle_faixa_3d.pular()

func _on_Vida_vida_acabou() -> void:
	TrocadorDeCenas.trocar_cena('res://recursos/feed_de_noticias/feed_de_noticia.tscn')
	
func imunidade(dano : bool, tempo : float):
	imunidade_time = tempo
	imune_dano = dano
	imune = true
	timer_imunidade.start()
	
func _on_TimerImunidade_timeout():
	if imune_dano:
		sprite.visible = not sprite.visible
	else:
		imunidade_modulate = not imunidade_modulate
		if imunidade_modulate:			
			sprite.modulate = Color (1.5, 1.5, 1)	
		else: 
			sprite.modulate = Color (1, 1, 1)	
	imunidade_time = imunidade_time - timer_imunidade.wait_time
	if imunidade_time <= 0:
		sprite.visible = true
		imune = false
		imune_dano = false
		imunidade_modulate = false
		sprite.modulate = Color (1, 1, 1)	
		timer_imunidade.stop()

func pause():
	var instance = menuOpcoes.instance()
	add_child(instance)
