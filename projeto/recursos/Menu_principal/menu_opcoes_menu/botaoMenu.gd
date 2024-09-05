extends Node

onready var opcoesMenu = preload("res://recursos/Menu_principal/menu_opcoes_menu/MenuDeOpcoes.tscn")

var menuApertado: bool = false

func _on_Menu_button_up():
	menuApertado = true
	var instanciaMenu = opcoesMenu.instance()
	if menuApertado:
		get_tree().get_root().add_child(instanciaMenu)
