extends AudioStreamPlayer

var _volume_atual = 999

func _ready():
	stream_paused = true
	SingletonOpcoesGlobais.connect("Atualizou", self, "_atualizar_volume")
	_atualizar_volume()

#Array de clipes de audio:
onready var clipesSFX = {
	"trocaFaixa": [
		preload ("res://elementos/audio/sfx/minigame-1/minigame1-player-mov1.mp3"),
		preload ("res://elementos/audio/sfx/minigame-1/minigame1-player-mov2.mp3"),
		preload ("res://elementos/audio/sfx/minigame-1/minigame1-player-mov3.mp3"),
		preload ("res://elementos/audio/sfx/minigame-1/minigame1-player-mov4.mp3"),
	],
	"dano": [
		preload ("res://elementos/audio/sfx/minigame-1/minigame1-player-bolha1.mp3"),
		preload ("res://elementos/audio/sfx/minigame-1/minigame1-player-bolha2.mp3"),
	]
	}

#Gerador de número randômico:
var rng = RandomNumberGenerator.new()

#Gatilho de troca de faixa:
func _on_ControleFaixa3D_iniciou_movimento(_direcao, _alvo) -> void:
	stop()
	stream = clipesSFX.trocaFaixa[rng.randi_range(0, clipesSFX.trocaFaixa.size() -1)]
	play()

#Gatilho de vida alterada:
func _on_Vida_vida_alterada(alteracao: Vida.VidaAlterada) -> void:
	if !alteracao.cura:
		stop()
		stream = clipesSFX.dano[rng.randi_range(0, clipesSFX.dano.size() -1)]
		play()
		
func _atualizar_volume():
	if SingletonOpcoesGlobais.volumeSFX != _volume_atual:
		_volume_atual = SingletonOpcoesGlobais.volumeSFX
		if _volume_atual == 0:				
			stream_paused = true
		else:
			stream_paused = false
			volume_db = range_lerp(_volume_atual, 1, 100, -30, 0)
