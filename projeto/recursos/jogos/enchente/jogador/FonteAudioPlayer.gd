extends AudioStreamPlayer

#Array de clipes de audio:
onready var clipesSFX = {
	"trocaFaixa": [
		preload ("res://elementos/audio/sfx/minigame-1/player-mov-1.wav"),
		preload ("res://elementos/audio/sfx/minigame-1/player-mov-2.wav"),
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
