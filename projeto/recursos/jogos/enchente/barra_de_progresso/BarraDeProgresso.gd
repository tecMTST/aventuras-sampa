extends Node2D


onready var icone = $Icone
onready var progresso = $ProgressoDeTextura


# Called when the node enters the scene tree for the first time.
func _ready():
	icone.position.y = _calcular_posicao()


func definir_valor(valor: float):
	progresso.value = valor
	icone.position.y = _calcular_posicao()


func _calcular_posicao():
	var altura = progresso.rect_size.y * progresso.rect_scale.y
	var inicio = progresso.rect_position.y + altura
	var posicao = altura * progresso.value / progresso.max_value
	return inicio - posicao
