class_name Jogador
extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var multiplicador_velocidade = 300
export (int) var maximo_seguidores = 5
export (int) var tempo_segundos = 180
export var loc_temporizador: NodePath
export var pontos_de_habilidade := 0

onready var sprite = $SpritesJogador as AnimatedSprite
onready var texto_seguidores = $texto_contador
onready var barra_tempo = $TempoRestante as ProgressBar
onready var temporizador = get_node(loc_temporizador) as Timer

var aleatorio = RandomNumberGenerator.new()
var _seguidores = []
var velocidade = Vector2()
var _movendo = false
var jogador = true

# Called when the node enters the scene tree for the first time.
func _ready():
	aleatorio.randomize()

	texto_seguidores.maximo = maximo_seguidores

	temporizador.wait_time = tempo_segundos
	temporizador.autostart = false
	temporizador.start()
	
	barra_tempo.max_value = tempo_segundos
	barra_tempo.value = temporizador.wait_time

func retirar_seguidor():
	return _seguidores.pop_back()

func adicionar_seguidor(seguidor):
	if _seguidores.size() >= maximo_seguidores:
		return false
	_seguidores.append(seguidor)
	
	return true

func remover_seguidor(seguidor):
	if seguidor in _seguidores:
		_seguidores.erase(seguidor)
	return seguidor

func get_input():
	velocidade = Vector2()
	if Input.is_action_pressed("right"):
		sprite.scale.x = 1
		velocidade.x += 1
		_movendo = true
	if Input.is_action_pressed("left"):
		sprite.scale.x = -1
		velocidade.x -= 1
		_movendo = true
	if Input.is_action_pressed("down"):
		velocidade.y += 1
		_movendo = true
	if Input.is_action_pressed("up"):
		velocidade.y -= 1
		_movendo = true
	velocidade = velocidade.normalized() * multiplicador_velocidade

func _process(delta):
	if velocidade.x<0:
		sprite.scale.x=-abs(sprite.scale.x)
	elif velocidade.x>0:
		sprite.scale.x=abs(sprite.scale.x)
	if _movendo:
		sprite.play("andar")
	else:
		sprite.play("parar")
	texto_seguidores.alterar_valor(_seguidores.size())
	barra_tempo.value = temporizador.time_left

func _physics_process(delta):
	velocidade = move_and_slide(velocidade)

func _on_alavanca_de_toque_alavanca_movida(posicao: Vector2):
	if not $BobAndando.playing:
		$BobAndando.play()
	velocidade = posicao.normalized() * multiplicador_velocidade
	_movendo = true

func _on_alavanca_de_toque_alavanca_solta():
	$BobAndando.stop()
	velocidade = Vector2.ZERO
	_movendo = false

func aumentar_maximo_seguidores(valor: int) -> bool:
	if pontos_de_habilidade <= 0:
		return false
	pontos_de_habilidade -= 1
	maximo_seguidores += valor
	texto_seguidores.alterar_maximo(maximo_seguidores)
	print(texto_seguidores.maximo)
	return true

func aumentar_area(valor: int) -> bool:
	if pontos_de_habilidade <= 0:
		return false
	pontos_de_habilidade -= 1
	maximo_seguidores += valor
	return true
