extends Spatial

onready var player_lane_3d = $playerLane3D as PlayerLane3D
onready var faixa_1 = $Faixas/Faixa1
onready var faixa_2 = $Faixas/Faixa2
onready var faixa_3 = $Faixas/Faixa3
onready var origem_obstaculos = $Faixas/OrigemObstaculos
onready var fps_label = $CanvasLayer/Control/HBoxContainer/FpsLabel


func _ready():
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_1.global_position)
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_2.global_position)
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_3.global_position)
	player_lane_3d.controle_faixa_3d.posicao_inicial = 1

func _process(_delta):
	fps_label.text = str(Engine.get_frames_per_second())


func _on_AreaColetoraObstaculos_body_entered(body):
	if((body as Node).is_in_group("obstaculo")):
		(body as Node).queue_free()
