tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Faixa2D", "Node2D",  preload("ControleFaixa2D.gd"), preload("icons/Faixa2D.svg"))

func _exit_tree():
	remove_custom_type("Faixa2D")
