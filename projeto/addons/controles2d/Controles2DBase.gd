extends Node2D
class_name BaseControle2D

# Classe base do componente de movimentação 2D

#Enum de modo de controle
enum modo_controle { autonomo, gatilho }
enum execucao_movimento { move_and_slide, move_and_collide, none }

#Sinais
signal corrida_iniciada
signal corrida_finalizada

#Variavel de ativação do componente
export var ativo = true

#Propriedades de controle - Associados aos inputs
export var controle_up = "up"
export var controle_down = "down"
export var controle_left = "left"
export var controle_right = "right"
export var controle_correr = "sprint"

#Propriedades de velocidade
#Velocidade base do personagem
export var velocidade_andar = 300.0
#Velocidade de sprint do personagem
export var velocidade_correr = 600.0
#Aceleração do movimento
export var aceleracao = 50.0
#Desaceleração do movimento
export var desaceleracao = 50.0

#Referencia do grupo de sprites para ter a direção invertida
export var referencia_sprites = "sprites"

#Se utiliza move_and_slide ou move_and_collide
export(execucao_movimento) var tipo_movimento = execucao_movimento.move_and_slide

#Váriaveis internas
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var correndo = false
var direcao_atual = 1
var velocidade : Vector2 = Vector2.ZERO
var grupo_sprites : Node2D

#Captura o parent que deve ser do tipo KinematicBody2D
onready var parent = get_parent() as KinematicBody2D

func _ready():
	grupo_sprites = parent.get_node(referencia_sprites)

func move():
	if ativo:
		if tipo_movimento == execucao_movimento.move_and_slide:
			parent.move_and_slide(velocidade, Vector2.UP)
		elif tipo_movimento == execucao_movimento.move_and_collide:
			parent.move_and_collide(velocidade)
