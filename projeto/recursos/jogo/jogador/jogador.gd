extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var multiplicador_velocidade = 200

onready var sprite = $SpritesJogador as AnimatedSprite

var velocidade = Vector2()
var _movendo = false
var jogador = true

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees = 0

func toque():
	pass

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
