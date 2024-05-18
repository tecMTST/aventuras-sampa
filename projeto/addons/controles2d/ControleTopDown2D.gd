extends BaseControle2D
class_name ControleTopDown2D

#Enumerados
enum modo_topdown{ direcional, rotacional, click }
enum modo_rotacao{ desativada, tudo, sprite_apenas }

#Modo de controle
export(modo_topdown)  var modo_de_controle = modo_topdown.direcional

#Propriedades de controle
export var controle_click = "click"

#Propriedades de rotação
export(modo_rotacao)  var rotacionar = modo_rotacao.tudo
export var velocidade_rotacao = 20.0
export var rotacao_travada_no_mouse = false

#Váriaveis internas
var alvo = Vector2()

func _input(_event):	
	if ativo and Input.is_action_just_released(controle_correr) and correndo:
		emit_signal("corrida_finalizada")
		correndo = false
			
func _process(delta):	
	if ativo:
		tratar_direcao(delta)
		move()	
	
func tratar_direcao(delta):	
	if modo_de_controle == modo_topdown.direcional:
		movimento_direcional(delta)
	elif modo_de_controle == modo_topdown.rotacional:
		movimento_rotacional(delta)
	else:
		movimento_click(delta)

func movimento_direcional(delta):
	var direcao = Input.get_vector(controle_left, controle_right, controle_up, controle_down).normalized()	
	var velocidade_atual = velociade_atual(direcao)	
	if direcao:	
		velocidade.x = move_toward(velocidade.x, direcao.x * velocidade_andar, aceleracao)
		velocidade.y = move_toward(velocidade.y, direcao.y * velocidade_andar, aceleracao)
	else:
		velocidade.x = move_toward(velocidade.x, 0, desaceleracao)
		velocidade.y = move_toward(velocidade.y, 0, desaceleracao)
	alvo = parent.global_position + direcao
	rotacionar(alvo, delta)

func movimento_rotacional(delta):
	var rotacao = 0
	velocidade = Vector2()
	var velocidade_atual = velociade_atual(true)	
	if Input.is_action_pressed(controle_right):
		rotacao += 1
	if Input.is_action_pressed(controle_left):
		rotacao -= 1
	if Input.is_action_pressed(controle_down):
		velocidade = Vector2(-velocidade_atual, 0).rotated(parent.rotation)
	if Input.is_action_pressed(controle_up):
		velocidade = Vector2(velocidade_atual, 0).rotated(parent.rotation)
	parent.rotation += rotacao * velocidade_rotacao * delta
	
func movimento_click(delta):
	if rotacao_travada_no_mouse:
		var alvo_olhar = get_global_mouse_position()
		rotacionar(alvo_olhar, delta)	
	if Input.is_action_pressed(controle_click):
		alvo = get_global_mouse_position()
		if not rotacao_travada_no_mouse:
			rotacionar(alvo, delta)		
		var velocidade_atual = velociade_atual(parent.position.distance_to(alvo) > 5)		
		velocidade = parent.position.direction_to(alvo) * velocidade_atual
	if parent.position.distance_to(alvo) <= 5:
		velocidade.x = 0
		velocidade.y = 0
		if correndo:
			correndo = false
			emit_signal("corrida_finalizada")

func rotacionar(alvo, delta):	
	if rotacionar == modo_rotacao.tudo:
		var rotacao_atual = parent.rotation
		parent.look_at(alvo)
		var rotacao_alvo = parent.rotation
		parent.rotation = lerp_angle(rotacao_atual, rotacao_alvo, velocidade_rotacao * delta)
	if rotacionar == modo_rotacao.sprite_apenas and grupo_sprites:
		var rotacao_atual = grupo_sprites.rotation
		grupo_sprites.look_at(alvo)
		var rotacao_alvo = grupo_sprites.rotation
		grupo_sprites.rotation = lerp_angle(rotacao_atual, rotacao_alvo, velocidade_rotacao * delta)

func velociade_atual(emitir_sinal):
	if Input.is_action_pressed(controle_correr) and not correndo and emitir_sinal:
		correndo = true
		emit_signal("corrida_iniciada")
		return velocidade_correr	
	return velocidade_andar
