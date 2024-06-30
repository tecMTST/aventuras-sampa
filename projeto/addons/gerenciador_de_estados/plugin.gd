tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Estado", "Node", load("res://addons/gerenciador_de_estados/estado.gd"), preload("res://addons/gerenciador_de_estados/estado.svg"))
	add_custom_type("MaquinaDeEstados", "Node", load("res://addons/gerenciador_de_estados/maquina_de_estados.gd"), preload("res://addons/gerenciador_de_estados/maquina-de-estados.svg"))


func _exit_tree():
	remove_custom_type("MaquinaDeEstados")
	remove_custom_type("Estado")
