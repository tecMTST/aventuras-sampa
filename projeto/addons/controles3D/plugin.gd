tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Lane3D", "Spatial",  preload("ControleFaixa3D.gd"), preload("icons/Lane3D.svg"))


func _exit_tree():
	remove_custom_type("Lane3D")
