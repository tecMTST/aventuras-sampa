extends Spatial

onready var faixa_1 = $Faixas/Faixa1
onready var faixa_2 = $Faixas/Faixa2
onready var faixa_3 = $Faixas/Faixa3
onready var origem_obstaculos = $OrigemObstaculos
onready var timer_da_mina_aquatica = $Timers/TimerDasMinasAquaticas
onready var timer_do_tentaculo = $Timers/TimerDoTentaculo
onready var timer_do_Ataque = $Timers/TimerAtaque
onready var Tentaculos = preload("res://recursos/jogos/enchente/chefao/Tentaculos.tscn")
onready var BombasChefe = preload("res://recursos/jogos/enchente/chefao/BombasChefe.tscn")

enum EstadoChefao {
	idle,
	mina_aquatica,
	tentaculo,
}

var EstadoAtual = EstadoChefao.idle
var UltimoEstado

func _ready():
	_idle()

func _idle():
	randomize()
	var ataque = randi() % 3 + 1
	print(ataque)

	if ataque == 1:
		EstadoAtual = EstadoChefao.idle

	elif ataque == 2:
		if UltimoEstado == EstadoChefao.tentaculo:
			EstadoAtual = EstadoChefao.idle
		else:
			EstadoAtual = EstadoChefao.tentaculo

	elif ataque == 3:
		EstadoAtual = EstadoChefao.mina_aquatica

	timer_do_Ataque.start(2.5)

func _on_TimerAtaque_timeout():
	match EstadoAtual:
		EstadoChefao.idle:
			_idle()
		EstadoChefao.mina_aquatica:
			_mina_aquatica()
		EstadoChefao.tentaculo:
			_tentaculo()

func _mina_aquatica():
	for faixa in range(2):
		randomize()
		var posicao = randi() % 3 + 1
		var instanciaMinaAquatica = BombasChefe.instance() as KinematicBody

		if posicao == 1:
			add_child(instanciaMinaAquatica)
			instanciaMinaAquatica.global_position = Vector3(faixa_1.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)

		elif posicao == 2:
			add_child(instanciaMinaAquatica)
			instanciaMinaAquatica.global_position = Vector3(faixa_2.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)

		elif posicao == 3:
				add_child(instanciaMinaAquatica)
				instanciaMinaAquatica.global_position = Vector3(faixa_3.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)

	UltimoEstado = EstadoChefao.mina_aquatica
	_idle()

func _tentaculo():
	randomize()
	var posicaoFaixa = randi() % 3 + 1
	var instanciaTentaculo = Tentaculos.instance()

	if posicaoFaixa == 1:
		add_child(instanciaTentaculo)
		instanciaTentaculo.global_position = faixa_1.global_position

	elif posicaoFaixa == 2:
		add_child(instanciaTentaculo)
		instanciaTentaculo.global_position = faixa_2.global_position

	elif posicaoFaixa == 3:
		add_child(instanciaTentaculo)
		instanciaTentaculo.global_position = faixa_3.global_position

	UltimoEstado = EstadoChefao.tentaculo
	_idle()

func _on_AreaColetoraObstaculos_body_entered(body):
	if((body as Node).is_in_group("obstaculo")):
		(body as Node).queue_free()
