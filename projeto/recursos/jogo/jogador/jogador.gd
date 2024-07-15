extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var multiplicador_velocidade = 200
export (int) var maximo_seguidores = 20
export (int) var tempo_segundos = 180
export var loc_temporizador: NodePath

onready var sprite = $SpritesJogador as AnimatedSprite
onready var barra_seguidores = $BarraSeguidores as ProgressBar
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
	
	barra_seguidores.max_value = maximo_seguidores
	
	temporizador.wait_time = tempo_segundos
	temporizador.autostart = false
	barra_tempo.max_value = tempo_segundos
	barra_tempo.value = temporizador.wait_time
	temporizador.start()

func toque():
	pass

func adicionar_seguidor(seguidor):
	if _seguidores.size() >= maximo_seguidores:
		return false
	_seguidores.append(seguidor)
	return true

func remover_seguidor(seguidor):
	if seguidor in _seguidores:
		_seguidores.remove(_seguidores.find(seguidor))

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
	barra_seguidores.value = _seguidores.size()
	barra_tempo.value = temporizador.time_left

func _physics_process(delta):
	velocidade = move_and_slide(velocidade)


func _on_alavanca_de_toque_alavanca_movida(posicao: Vector2):
	if not $BobAndando.playing:
		$BobAndando.play()
	velocidade = posicao.normalized() * multiplicador_velocidade
	move_and_slide(velocidade)
	_movendo = true


func _on_alavanca_de_toque_alavanca_solta():
	$BobAndando.stop()
	velocidade = Vector2.ZERO
	_movendo = false
