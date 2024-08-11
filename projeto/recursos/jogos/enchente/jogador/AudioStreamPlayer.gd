extends AudioStreamPlayer

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
