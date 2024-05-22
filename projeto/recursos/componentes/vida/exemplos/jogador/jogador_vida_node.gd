extends Node2D

onready var vida := $VidaNode

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		vida.receber_dano(1)
	if event.is_action_pressed("ui_up"):
		vida.curar(1)

func _process(_delta: float) -> void:
	$Label.text = "Vida: %s" % vida.vida_atual
