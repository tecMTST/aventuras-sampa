extends Node

onready var opcoesMenu = preload("res://recursos/Menu_principal/menu_opcoes/MenuDeOpcoes.tscn")
onready var tween = $CanvasLayer/Menu/Tween

var menuApertado: bool = false

func _on_Menu_button_up():
	menuApertado = true
	var instanciaMenu = opcoesMenu.instance()
	if menuApertado:
		tween.interpolate_property($CanvasLayer/Menu, "rect_scale", Vector2(1,1), Vector2(1.2,1.2), 0.4, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
		tween.interpolate_property($CanvasLayer/Menu, "rect_scale", Vector2(1.2,1.2), Vector2(1,1), 0.4, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
		get_tree().get_root().add_child(instanciaMenu)
