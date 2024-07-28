extends AudioStreamPlayer

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
	stream = clipesSFX.trocaFaixa[rng.randi_range(0, clipesSFX.trocaFaixa.size() -1)]
	play()

#Gatilho de vida alterada:
func _on_Vida_vida_alterada(alteracao: Vida.VidaAlterada) -> void:
	if !alteracao.cura:
		stop()
		stream = clipesSFX.dano[rng.randi_range(0, clipesSFX.dano.size() -1)]
		play()
