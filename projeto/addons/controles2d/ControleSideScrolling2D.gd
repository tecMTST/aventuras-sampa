extends BaseControle2D
class_name ControleSideScroling2D

#Propriedades de controle
export(modo_controle) var modo = modo_controle.autonomo
export var controle_no_ar = true
export var tratar_gravidade = true

#Multiplica o valor global da gravidade, para ajuste fino do pulo
export var multiplicador_de_gravidade : float = 1.0

#Sinais
signal chao_atingido

#Variáveis internas
var noChao = false

func processar(direction, delta) -> Vector2:
	if ativo:
		tratar_no_chao()	
		if tratar_gravidade:
			tratar_gravidade()
		tratar_direcao(direction)
	return velocidade

func _input(_event):
	if ativo and modo == modo_controle.autonomo:
		if Input.is_action_just_released(controle_correr) and correndo:
			emit_signal("corrida_finalizada")
			correndo = false

func _physics_process(delta: float) -> void:
	if ativo and modo == modo_controle.autonomo:
		var direction = Input.get_axis(controle_left, controle_right)	
		processar(direction, delta)
		move()

#Tratamento da gravidade
func tratar_gravidade():
	if not parent.is_on_floor():	
		velocidade.y += gravity * multiplicador_de_gravidade

#Tratamento das ações tocar o chão
func tratar_no_chao():
	var estava_no_chao = noChao
	noChao = parent.is_on_floor()
	if noChao != estava_no_chao:
		emit_signal("chao_atingido")

#Tratamento das ações de direcionamento
func tratar_direcao(direction):
	if not controle_no_ar and not parent.is_on_floor():
		return
	var velocidade_atual = velocidade_andar
	if Input.is_action_pressed(controle_correr) and not correndo and direction:
			correndo = true
			emit_signal("corrida_iniciada")
			velocidade_atual = velocidade_correr
	if direction:
		velocidade.x = move_toward(velocidade.x, direction * velocidade_andar, aceleracao)
		if direction > 0:
			if grupo_sprites:
				grupo_sprites.scale.x = 1
			direcao_atual = 1
		else:			
			if grupo_sprites:
				grupo_sprites.scale.x = -1
			direcao_atual = -1
	else:
		velocidade.x = move_toward(velocidade.x, 0, desaceleracao)
