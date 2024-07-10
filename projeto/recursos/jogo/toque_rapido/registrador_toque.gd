extends Node2D


export var quantidade_de_toques := 20
export var tempo_segundos := 5
export var lugar_temporizador: NodePath

signal finalizado(sucesso)
signal toque

var perdeu = false
var _toques_realizados = 0
var _inicializado = false

onready var _temporizador = get_node(lugar_temporizador) as Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	_temporizador.one_shot = true
	_temporizador.connect("timeout", self, "_on_Temporizador_timeout")
	_toques_realizados = 0
	perdeu = false
	_inicializado = false


func toques_realizados():
	return _toques_realizados


func inicializar():
	_inicializado = true
	_temporizador.start(tempo_segundos)
	_toques_realizados = 0
	perdeu = false


func _on_ControleDeToque_toque_realizado(historico):
	if (not _inicializado) or (_toques_realizados >= quantidade_de_toques) or perdeu:
		return
	_toques_realizados+=1
	emit_signal("toque")
	if _toques_realizados >= quantidade_de_toques:
		emit_signal("finalizado", true)


func _on_Temporizador_timeout():
	if _toques_realizados >= quantidade_de_toques:
		return
	emit_signal("finalizado", false)
	perdeu = true
