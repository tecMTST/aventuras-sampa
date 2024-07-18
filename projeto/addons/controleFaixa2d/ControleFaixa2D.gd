extends Node2D
class_name ControleFaixa2D

#enums
enum modo_controle { autonomo, gatilho	}
enum modos_orientacao { horizontal, vertical, ambas }

#constantes
const DISTANCIA_MAXIMA = 9999.0
const DISTANCIA_MINIMA = 5.0
const DISTANCIA_PARADA = 2.0

#Variavel de ativação do componente
export var ativo = true

#modo
export(modo_controle) var modo = modo_controle.autonomo
export(modos_orientacao) var orientacao = modos_orientacao.horizontal

#inputs
export var controle_left = "left"
export var controle_right = "right"

#velocidade
export var velocidade_movimento = 300.0
export var aceleracao = 20.0
export var desaceleracao = 20.0

#Faixas
export(Array, Vector2) var faixas = []
export(int) var posicao_inicial = 0

#Captura o parent que deve ser do tipo KinematicBody2D
onready var parent = get_parent() as KinematicBody2D


#Váriaveis internas
var alvo = Vector2()
var posicao_atual = 0
var alvo_definido = false
var velocidade : Vector2 = Vector2.ZERO
var ultima_distancia = DISTANCIA_MAXIMA

func _ready():
	posicao_atual = posicao_inicial
	definir_alvo();

func _input(_event):	
	if ativo and modo == modo_controle.autonomo:		
		if Input.is_action_just_pressed(controle_left):
			ultima_distancia = DISTANCIA_MAXIMA
			mover_direita()
		if Input.is_action_just_pressed(controle_right):
			ultima_distancia = DISTANCIA_MAXIMA
			mover_esquerda()	
			
func _process(delta):	
	if ativo and modo == modo_controle.autonomo and faixas.size() > 0:
		processar()
		parent.move_and_slide(velocidade, Vector2.UP)
			
func mover_direita():
	if posicao_atual > 0:
		posicao_atual = posicao_atual - 1;
		definir_alvo()
		
func mover_esquerda():
	if posicao_atual < faixas.size() - 1:
		posicao_atual = posicao_atual + 1;
		definir_alvo()
	
func definir_alvo():
	if faixas.size() > 0:		
		if orientacao == modos_orientacao.horizontal:
			alvo = Vector2(faixas[posicao_atual].x, parent.global_position.y) 
		elif orientacao == modos_orientacao.vertical:
			alvo = Vector2(parent.global_position.x, faixas[posicao_atual].y) 
		else:
			alvo = faixas[posicao_atual]
		alvo_definido = true

func processar() -> Vector2:	
	if not alvo_definido:
		definir_alvo()
	var distancia = parent.position.distance_to(alvo)
	if faixas.size() > 0 and distancia > DISTANCIA_MINIMA and distancia < ultima_distancia:
		velocidade.y = move_toward(velocidade.y, (parent.position.direction_to(alvo).y * velocidade_movimento), aceleracao) 
		velocidade.x = move_toward(velocidade.x, (parent.position.direction_to(alvo).x * velocidade_movimento), aceleracao) 
	elif faixas.size() > 0 and distancia <= DISTANCIA_MINIMA and distancia > DISTANCIA_PARADA and distancia < ultima_distancia:
		velocidade.y = move_toward(velocidade.y, 0, desaceleracao) 
		velocidade.x = move_toward(velocidade.x, 0, desaceleracao) 
	else:
		velocidade = Vector2.ZERO
	ultima_distancia = distancia
	return velocidade
