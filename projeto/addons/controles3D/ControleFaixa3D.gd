extends Spatial
class_name ControleFaixa3D

#enums
enum modo_controle { autonomo, gatilho	}
enum modos_orientacao { x, y, z, plano_xy, plano_xz, plano_yz, todos }

#constantes
const DISTANCIA_MAXIMA = 9999.0
const DISTANCIA_MINIMA = 0.3
const DISTANCIA_PARADA = 0.1

#Variavel de ativação do componente
export var ativo = true

#modo
export(modo_controle) var modo = modo_controle.autonomo
export(modos_orientacao) var orientacao = modos_orientacao.x

#inputs
export var controle_left = "left"
export var controle_right = "right"

#velocidade
export var velocidade_movimento = 10.0
export var aceleracao = 2.0
export var desaceleracao = 2.0

#Faixas
export(Array, Vector3) var faixas = []
export(int) var posicao_inicial = 0

#Captura o parent que deve ser do tipo KinematicBody
onready var parent = get_parent() as KinematicBody


#Váriaveis internas
var alvo = Vector3()
var posicao_atual = 0
var alvo_definido = false
var velocidade : Vector3 = Vector3.ZERO
var ultima_distancia = DISTANCIA_MAXIMA

func _ready():
	posicao_atual = posicao_inicial
	definir_alvo();

func _input(_event):	
	if ativo and modo == modo_controle.autonomo:		
		if Input.is_action_just_pressed(controle_left):			
			mover_esquerda()	
		if Input.is_action_just_pressed(controle_right):			
			mover_direita()
			
func _process(delta):	
	if ativo and modo == modo_controle.autonomo and faixas.size() > 0:
		processar()
		parent.move_and_slide(velocidade, Vector3.UP)
			
func mover_direita():
	ultima_distancia = DISTANCIA_MAXIMA
	if posicao_atual < faixas.size() - 1:
		posicao_atual = posicao_atual + 1;
		definir_alvo()
		
func mover_esquerda():
	ultima_distancia = DISTANCIA_MAXIMA
	if posicao_atual > 0:
		posicao_atual = posicao_atual - 1;
		definir_alvo()
	
func definir_alvo():
	if faixas.size() > 0:		
		if orientacao == modos_orientacao.x:
			alvo = Vector3(faixas[posicao_atual].x, parent.global_position.y, parent.global_position.z) 
		elif orientacao == modos_orientacao.y:
			alvo = Vector3(parent.global_position.x, faixas[posicao_atual].y, parent.global_position.z) 
		elif orientacao == modos_orientacao.z:
			alvo = Vector3(parent.global_position.x, parent.global_position.y, faixas[posicao_atual].z) 		
		elif orientacao == modos_orientacao.plano_xy:
			alvo = Vector3(faixas[posicao_atual].x, faixas[posicao_atual].y, parent.global_position.z) 			
		elif orientacao == modos_orientacao.plano_xz:
			alvo = Vector3(faixas[posicao_atual].x, parent.global_position.y, faixas[posicao_atual].z) 			
		elif orientacao == modos_orientacao.plano_yz:
			alvo = Vector3(parent.global_position.x, faixas[posicao_atual].y, faixas[posicao_atual].z) 		
		else:
			alvo = faixas[posicao_atual]
		alvo_definido = true

func processar() -> Vector3:	
	if not alvo_definido:
		definir_alvo()
	var distancia = parent.position.distance_to(alvo)
	if faixas.size() > 0 and distancia > DISTANCIA_MINIMA and distancia < ultima_distancia:
		velocidade.y = move_toward(velocidade.y, (parent.position.direction_to(alvo).y * velocidade_movimento), aceleracao) 
		velocidade.x = move_toward(velocidade.x, (parent.position.direction_to(alvo).x * velocidade_movimento), aceleracao) 
		velocidade.z = move_toward(velocidade.z, (parent.position.direction_to(alvo).z * velocidade_movimento), aceleracao) 
	elif faixas.size() > 0 and distancia <= DISTANCIA_MINIMA and distancia > DISTANCIA_PARADA and distancia < ultima_distancia:
		velocidade.y = move_toward(velocidade.y, 0, desaceleracao) 
		velocidade.x = move_toward(velocidade.x, 0, desaceleracao) 
		velocidade.z = move_toward(velocidade.z, 0, desaceleracao) 
	else:
		velocidade = Vector3.ZERO
	ultima_distancia = distancia
	return velocidade
