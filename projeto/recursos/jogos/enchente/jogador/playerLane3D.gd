extends KinematicBody
class_name PlayerLane3D

onready var controle_faixa_3d = $ControleFaixa3D
onready var vida = $Vida as Vida


func _on_AreaDano_body_entered(body: Node) -> void:
	if(body.is_in_group('obstaculo')):
		vida.receber_dano(1.0)
