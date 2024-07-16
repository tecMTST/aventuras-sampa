extends Node2D


export var numero_de_pessoas = 15


var aleatorio = RandomNumberGenerator.new()
var pessoas: Array = []
var referencia_jogador: KinematicBody2D

onready var barra_de_progresso = $BarraDeProgresso as ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	aleatorio.randomize()
	barra_de_progresso.max_value = numero_de_pessoas


func _process(delta):
	barra_de_progresso.value = pessoas.size()


func _on_Area2D_body_entered(body):
	referencia_jogador = body


func _on_Area2D_body_exited(body):
	referencia_jogador = null


func _on_ControleDeToque_toque_realizado(historico):
	if not referencia_jogador or pessoas.size() >= numero_de_pessoas:
		return

	var novo_seguidor = referencia_jogador.retirar_seguidor()
	if novo_seguidor == null:
		return
	print('toque')
	pessoas.append(novo_seguidor)
	novo_seguidor.mobilizar(self)

