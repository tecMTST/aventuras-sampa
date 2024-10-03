extends BaseControle2D
class_name ControlePulo2D

#Propriedades de controle
export var controle_pulo_variavel = true
export(modo_controle) var modo = modo_controle.autonomo

#Propriedades de controle
export var controle_pulo = "jump"

#Propriedades de velocidade
export var velocidade_pulo = 900.0

#Tempo de Buffer do Pulo, para que o pulo possa ser acionado mesmo instantes antes de tocar o chão
export var tempo_de_buffer_de_pulo : float = 0.1

#Tempo de Coyote, para que o pulo possa ser acionado mesmo instantes apos cair de uma plataforma
export var tempo_de_coyote : float = 0.1

#Multiplica o valor global da gravidade, para ajuste fino do pulo
export var multiplicador_de_gravidade : float = 1.0

#Multiplica o valor da gravidade, mas apenas quando estiver caindo (acumulativo com o multiplicador_de_gravidade)
export var multiplicador_de_queda : float = 1.1

#Sinais
signal inicio_de_pulo
signal topo_do_pulo
signal fim_do_pulo

#Variáveis internas
var timer_buffer_pulo: float = 0.0
var timer_coyote: float = 0.0
var pulando = false
var cancelar_pulo = false
var noChao = false
var gatilho_pulo = false
var pulo_crescente = false

func pular():
	if modo == modo_controle.gatilho:
		timer_buffer_pulo = tempo_de_buffer_de_pulo		
	
func finalizar_pulo():
	if modo == modo_controle.gatilho:
		cancelar_pulo  = true		

func processar(delta) -> Vector2:
	if ativo:
		tratar_no_chao()	
		tratar_gravidade()
		tratar_pulo(delta)		
	return velocidade

func _input(_event):
	if ativo and modo == modo_controle.autonomo:
		if Input.is_action_just_pressed(controle_pulo):
			timer_buffer_pulo = tempo_de_buffer_de_pulo
		if controle_pulo_variavel and Input.is_action_just_released(controle_pulo) and pulando and velocidade.y < 0:
			cancelar_pulo  = true

func _physics_process(delta: float) -> void:
	if ativo and modo == modo_controle.autonomo:
		processar(delta)
		move()

#Tratamento da gravidade
func tratar_gravidade():
	if not parent.is_on_floor() and not timer_coyote > 0:
		if velocidade.y < 0:
			velocidade.y += gravity * multiplicador_de_gravidade
			pulo_crescente = true
		else:
			if pulo_crescente:
				emit_signal("topo_do_pulo")
			velocidade.y += (gravity * multiplicador_de_gravidade) * multiplicador_de_queda	
			pulo_crescente = false
	if timer_coyote > 0 and not pulando:
		velocidade.y = 0

#Tratamento das ações tocar o chão
func tratar_no_chao():
	var estava_no_chao = noChao
	noChao = parent.is_on_floor()
	if noChao != estava_no_chao and not pulando:
		emit_signal("fim_do_pulo")

#Tratamento ações do pulo
func tratar_pulo(delta):
	if parent.is_on_floor():
		timer_coyote = tempo_de_coyote
	
	if pulando and cancelar_pulo:
		velocidade.y = 0
		pulando = false
		cancelar_pulo  = false
	
	timer_buffer_pulo -= delta
	timer_coyote -= delta
	
	if pulando and parent.is_on_floor():
		pulando = false
	
	if timer_buffer_pulo > 0 and (parent.is_on_floor() or (timer_coyote > 0 and not pulando)) :
		timer_coyote = 0
		pulando = true
		velocidade.y = (velocidade_pulo	* -1)
		emit_signal("inicio_de_pulo")
