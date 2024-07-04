extends Spatial

# Tempo de jogo em minutos
export var tempo_jogo = 5

onready var player_lane_3d = $playerLane3D as PlayerLane3D
onready var faixa_1 = $Faixas/Faixa1
onready var faixa_2 = $Faixas/Faixa2
onready var faixa_3 = $Faixas/Faixa3
onready var fps_label = $CanvasLayer/Control/HBoxContainer/FpsLabel
onready var agua = $Agua

onready var _tempo = $TempoDeJogo

func _ready():
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_1.global_position)
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_2.global_position)
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_3.global_position)
	player_lane_3d.controle_faixa_3d.posicao_inicial = 1
	_tempo.wait_time = tempo_jogo * 60
	_tempo.start()


func _process(_delta):
	fps_label.text = str(Engine.get_frames_per_second())
	agua.get_active_material(0).set_shader_param("Velocidade",EnchenteEstadoDeJogo.VelocidadeGlobal);
