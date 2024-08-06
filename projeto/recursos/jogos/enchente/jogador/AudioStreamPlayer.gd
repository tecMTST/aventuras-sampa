extends AudioStreamPlayer

var _volume_atual = 999

func _ready():
	stream_paused = true

func _process(delta):
	_check_volume()

#Array de clipes de audio:
onready var clipesSFX = {
	"trocaFaixa": [
		preload ("res://elementos/audio/sfx/minigame-1/player-mov-1.wav"),
		preload ("res://elementos/audio/sfx/minigame-1/player-mov-2.wav"),
		preload ("res://elementos/audio/sfx/minigame-1/player-mov-3.wav"),
		preload ("res://elementos/audio/sfx/minigame-1/player-mov-4.wav"),
	],
	"dano": [
		preload ("res://elementos/audio/sfx/minigame-1/player-bolha-1.wav"),
		preload ("res://elementos/audio/sfx/minigame-1/player-bolha-2.wav"),
	]
	}

#Gerador de número randômico:
var rng = RandomNumberGenerator.new()

#Gatilho de troca de faixa:
func _on_ControleFaixa3D_iniciou_movimento(_direcao, _alvo) -> void:
	stop()
	stream = clipesSFX.trocaFaixa[rng.randf_range(0, clipesSFX.trocaFaixa.size())]
	play()

#Gatilho de vida alterada:
func _on_Vida_vida_alterada(alteracao: Vida.VidaAlterada) -> void:
	if !alteracao.cura:
		stop()
		stream = clipesSFX.dano[rng.randf_range(0, clipesSFX.dano.size())]
		play()
		
func _check_volume():
	if SingletonOpcoesGlobais.volumeSFX != _volume_atual:
		_volume_atual = SingletonOpcoesGlobais.volumeSFX
		if _volume_atual == 0:				
			stream_paused = true
			stream_paused = true
		else:
			stream_paused = false
			volume_db = FuncGlobais.map(_volume_atual, 1, 100, -30, 0)
