extends Node

export var menupath: String = 'res://recursos/Menu_principal/Menu_Principal.tscn'


func _ready():
	pass # Replace with function body.


func _on_VoltarMenu_button_up():
	get_tree().paused = false
	TrocadorDeCenas.trocar_cena(menupath)
