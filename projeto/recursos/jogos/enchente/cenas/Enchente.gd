extends Spatial

# Tempo de jogo em minutos
export var tempo_jogo = 5

onready var player_lane_3d = $playerLane3D as PlayerLane3D
onready var faixa_1 = $Faixas/Faixa1
onready var faixa_2 = $Faixas/Faixa2
onready var faixa_3 = $Faixas/Faixa3
onready var fps_label = $CanvasLayer/Control/HBoxContainer/FpsLabel
onready var tempo_label = $CanvasLayer/Control/HBoxContainer/Tempo
onready var agua = $Agua
onready var audio_stream_bgm = $AudioStreamBGM
onready var audio_stream_amb = $AudioStreamAMB

var _volume_atual = 999

func _ready():
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_1.global_position)
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_2.global_position)
	player_lane_3d.controle_faixa_3d.faixas.append(faixa_3.global_position)
	player_lane_3d.controle_faixa_3d.posicao_inicial = 1

	EnchenteEstadoDeJogo.TemporizadorGlobal = $TempoDeJogo
	EnchenteEstadoDeJogo.definir_tempo_de_jogo(tempo_jogo * 60)
	EnchenteEstadoDeJogo.iniciar_temporizador()
	EnchenteEstadoDeJogo.set_process(true)
	
	

func _process(_delta):
	fps_label.text = str(Engine.get_frames_per_second())
	tempo_label.text = String(EnchenteEstadoDeJogo.TempoAtual)
	agua.get_active_material(0).set_shader_param("Velocidade", EnchenteEstadoDeJogo.VelocidadeGlobal)
	_check_volume()

func _exit_tree() -> void:
	EnchenteEstadoDeJogo.set_process(false)

func _check_volume():
	if SingletonOpcoesGlobais.volumeSom != _volume_atual:
		_volume_atual = SingletonOpcoesGlobais.volumeSom
		if _volume_atual == 0:				
			audio_stream_amb.stream_paused = true
			audio_stream_bgm.stream_paused = true
		else:
			audio_stream_amb.stream_paused = false
			audio_stream_bgm.stream_paused = false
			audio_stream_amb.volume_db = FuncGlobais.map(_volume_atual, 1, 100, -30, 0)
			audio_stream_bgm.volume_db = FuncGlobais.map(_volume_atual, 1, 100, -30, 0)
		
	

	
