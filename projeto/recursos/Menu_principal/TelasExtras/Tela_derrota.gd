extends Node

export var jogarnovamente: String = "res://recursos/jogos/enchente/cenas/Enchente.tscn"


func _ready():
	pass # Replace with function body.

func _on_Voltarjogo_button_up():
	get_tree().paused = false
	TrocadorDeCenas.trocar_cena(jogarnovamente)

func _on_Voltarjogo_button_down():
	$AudioStreamSFX.stream.loop = false
	$AudioStreamSFX.play()
