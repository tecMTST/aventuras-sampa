extends KinematicBody
class_name PlayerLane3D

onready var controle_faixa_3d = $ControleFaixa3D


func _on_ControladorArrasta_arrastado(chave):
	if chave=='direita':
		controle_faixa_3d.mover_direita()
	elif chave=='esquerda':
		controle_faixa_3d.mover_esquerda()
