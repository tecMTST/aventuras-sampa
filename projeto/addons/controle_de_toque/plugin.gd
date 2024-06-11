tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("ControleDeToque", "Node", preload("res://addons/controle_de_toque/controle_toque.gd"), preload("res://addons/controle_de_toque/icon.svg"))


func _exit_tree():
	remove_custom_type("ControleDeToque")
