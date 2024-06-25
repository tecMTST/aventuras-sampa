extends KinematicBody
class_name PlayerLane3D

onready var controle_faixa_3d = $ControleFaixa3D
onready var vida = $Vida as Vida


func _on_ControladorArrasta_arrastado(chave):
	if chave=='direita':
		controle_faixa_3d.mover_direita()
		print('a')
	elif chave=='esquerda-0' or chave=='esquerda-1':
		controle_faixa_3d.mover_esquerda()


func _on_AreaDano_body_entered(body: Node) -> void:
	if body.is_in_group("obstaculo"):
		vida.receber_dano(1.0)


func _on_Vida_vida_acabou() -> void:
	TrocadorDeCenas.trocar_cena('res://recursos/feed_de_noticias/feed_de_noticia.tscn')
