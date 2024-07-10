extends Node2D
class_name FabricaSeguidores


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var aleatorio = RandomNumberGenerator.new()
var pessoa = preload("res://recursos/jogo/pessoa/pessoa.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func gerar_vetor_aleatorio(raio: int):
	return Vector2(
		aleatorio.randf_range(-raio, raio),
		aleatorio.randf_range(-raio, raio))

func adicionar_seguidores(jogador,quantidade=0):
	for i in range(quantidade):
		var nova_pessoa = pessoa.instance()
		nova_pessoa.definir_alvo(jogador)
		nova_pessoa.position = jogador.position + gerar_vetor_aleatorio(300)
		get_parent().add_child(nova_pessoa)

