extends Spatial

onready var faixa_1 = $Faixas/Faixa1
onready var faixa_2 = $Faixas/Faixa2
onready var faixa_3 = $Faixas/Faixa3
onready var origem_obstaculos = $OrigemObstaculos
onready var timer_do_Ataque = $Timers/TimerAtaque
onready var timer_modulo = $Timers/TimerModos
onready var boss_sprite = $Sprites/SpriteChefao
onready var Tentaculos = preload("res://recursos/jogos/enchente/chefao/Tentaculos.tscn")
onready var BombasChefe = preload("res://recursos/jogos/enchente/chefao/BombasChefe.tscn")
onready var bossendtween = $Sprites/SpriteChefao/Tween

signal Chefao_Derrotado

#	"tipo_de_obstaculo": {
#		"1": "mina_aquatica",
#		"2": "tentaculo"

enum ModulosDisponiveis {
	vinte_sec,
	quarenta_sec,
	sessenta_sec,
	acabou
}

var ModuloAtual
var lista_posicoes
var timer_atual: int = 0 # maximo é 3
var CAMINHO_MODULO = 'res://recursos/jogos/enchente/chefao/modulos.json'
var conteudo_total_modulo = loadJson(CAMINHO_MODULO)

func _ready():
	print(conteudo_total_modulo)
	print(timer_atual)
	_mudaModulo()
	adicionar_lista('20_sec', 1)
	timer_modulo.start(28)

func adicionar_lista(modulo_atual, ataque):
	print(modulo_atual)
	var Id_conteudo_modulo = conteudo_total_modulo.get(String(modulo_atual))
	lista_posicoes = Id_conteudo_modulo.get(String(ataque))
	if ModuloAtual == ModulosDisponiveis.sessenta_sec:
		lista_posicoes += Id_conteudo_modulo.get(String(ataque) + String('_1'))
	print(lista_posicoes)
#		if item.has(modulo_atual):

func _on_TimerModos_timeout():
	timer_atual += 1
	print(timer_atual)

func _mudaModulo():
	if timer_atual == 0:
		ModuloAtual = ModulosDisponiveis.vinte_sec
	elif timer_atual == 1:
		ModuloAtual = ModulosDisponiveis.quarenta_sec
	elif timer_atual == 2:
		ModuloAtual = ModulosDisponiveis.sessenta_sec
	elif timer_atual == 3:
		ModuloAtual = ModulosDisponiveis.acabou
		timer_modulo.stop()

func _realizar_acao():
	randomize()
	var random_ataque = randi() % 3 + 1
	match ModuloAtual:
		ModulosDisponiveis.vinte_sec:
			adicionar_lista("20_sec", random_ataque)
			_realizar_ataque()
		ModulosDisponiveis.quarenta_sec:
			adicionar_lista("40_sec", random_ataque)
			_realizar_ataque()
		ModulosDisponiveis.sessenta_sec:
			adicionar_lista("60_sec", random_ataque)
			_realizar_ataque()
		ModulosDisponiveis.acabou:
			_auto_destruir()

	timer_do_Ataque.start(7)
	_mudaModulo()

func _on_TimerAtaque_timeout():
	_realizar_acao()

func _realizar_ataque():
	var lane_atual = 1

	for obj_pos in lista_posicoes:
		var instanciaMinaAquatica = BombasChefe.instance() as KinematicBody
		var instanciaTentaculo = Tentaculos.instance() as KinematicBody
		print(obj_pos)
		if lane_atual == 4:
			yield(get_tree().create_timer(0.3), "timeout")
			lane_atual = 1

		if obj_pos == 0:
			instanciaMinaAquatica.queue_free()
			instanciaTentaculo.queue_free()
		elif obj_pos == 1:
			add_child(instanciaMinaAquatica)
			if lane_atual == 1:
				instanciaMinaAquatica.global_position = Vector3(faixa_1.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)
			elif lane_atual == 2:
				instanciaMinaAquatica.global_position = Vector3(faixa_2.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)
			elif lane_atual == 3:
				instanciaMinaAquatica.global_position = Vector3(faixa_3.global_position.x, origem_obstaculos.global_position.y, origem_obstaculos.global_position.z)

		elif obj_pos == 2:
			add_child(instanciaTentaculo)
			if lane_atual == 1:
				instanciaTentaculo.global_position = faixa_1.global_position
			elif lane_atual == 2:
				instanciaTentaculo.global_position = faixa_2.global_position
			elif lane_atual == 3:
				instanciaTentaculo.global_position = faixa_3.global_position

		lane_atual += 1

func loadJson(nomejson):
	var arquivo = File.new()
	if arquivo.file_exists(nomejson):
		arquivo.open(nomejson, arquivo.READ)
		var conteudo = parse_json(arquivo.get_as_text())
		if conteudo == null:
			print("Could not parse " + nomejson + " as JSON." + \
			"Porfavor cheque se o path está certo.")
		#print(conteudo)
		return conteudo
	else:
		print("File Open Error: could not open file " + nomejson)
	arquivo.close()

func _auto_destruir():
	bossendtween.interpolate_property(boss_sprite,  "translation", Vector3(-0.079, 4.143, 6.825), Vector3(-0.079, -6.971, 6.825), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	yield(get_tree().create_timer(0.7), "timeout")
	bossendtween.start()

func _on_Tween_tween_completed(object, key):
	emit_signal("Chefao_Derrotado")
	yield(get_tree().create_timer(2), "timeout")
	self.queue_free()
