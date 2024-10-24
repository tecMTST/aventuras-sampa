extends Node

export var menupath: String = 'res://recursos/Menu_principal/Menu_Principal.tscn'

onready var audio_stream_bgm = $AudioStreamBGM
onready var audio_stream_sfx = $AudioStreamSFX

func _ready():
	audio_stream_bgm.stream.loop = false
	audio_stream_bgm.play()

func _on_VoltarMenu_button_up():
	get_tree().paused = false
	TrocadorDeCenas.trocar_cena(menupath)

func _on_VoltarMenu_button_down():
	audio_stream_sfx.stream.loop = false
	audio_stream_sfx.play()
