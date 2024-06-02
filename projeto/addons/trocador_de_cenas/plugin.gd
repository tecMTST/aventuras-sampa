tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton('TrocadorDeCenas', 'res://addons/trocador_de_cenas/trocador_de_cenas.tscn')

func _exit_tree():
	remove_autoload_singleton('TrocadorDeCenas')
