extends Node2D

# abencoado seja o https://randommomentania.com/2018/08/godot-touch-screen-joystick-part-1/

export var raio_tolerancia = 400

signal alavanca_movida(posicao)
signal alavanca_solta

onready var _toque = $ControleDeToque
onready var _sprite_topo = $Topo

func _mover_alavanca(posicao: Vector2):
	if posicao.length() > raio_tolerancia:
		return
	var diferenca = posicao
	emit_signal("alavanca_movida", diferenca)
	_sprite_topo.position = diferenca.normalized() * 50


func _on_ControleDeToque_arrastar_realizado(historico):
	_mover_alavanca(get_local_mouse_position())


func _on_ControleDeToque_toque_desfeito(historico):
	emit_signal("alavanca_solta")
	_sprite_topo.position = Vector2.ZERO


func _on_ControleDeToque_toque_realizado(historico):
	_mover_alavanca(get_local_mouse_position())


