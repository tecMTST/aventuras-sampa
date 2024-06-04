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


func _on_TimerObstaculos_timeout():
	randomize()
	var posicao = randi() % 3 + 1
	var obstaculo = load("res://recursos/jogos/enchente/componentes/Obstaculo.tscn")
			
	for faixa in range(3):
		if posicao - 1 != faixa:
			if faixa == 0:				
				var instancia0 = obstaculo.instance() as KinematicBody
				add_child(instancia0)
				instancia0.global_position = Vector3(faixa_1.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)
			elif faixa == 1:				
				var instancia1 = obstaculo.instance() as KinematicBody
				add_child(instancia1)
				instancia1.global_position = Vector3(faixa_2.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)
			else:
				var instancia2 = obstaculo.instance() as KinematicBody
				add_child(instancia2)
				instancia2.global_position = Vector3(faixa_3.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)
		
func _on_AreaColetoraObstaculos_body_entered(body):
	if((body as Node).is_in_group("obstaculo")):
		(body as Node).queue_free()
