extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var multiplicador_velocidade = 500
export var textos = [
	'sigam-me os bons',
	'bora minha gente!',
	'simbora!',
	'vamo pra rua'
]

onready var animador = $Animador as AnimationPlayer
onready var sprite = $SpritesJogador as AnimatedSprite

var velocidade = Vector2()
var _movendo = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animador.play("idle")
	rotation_degrees = 0

func toque():
	animador.play("squash")

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
	if Input.is_action_pressed("acao"):
		if not $Sprite.visible:
			$Sprite.visible = true
			$Sprite/RichTextLabel.text = textos.pick_random()
	velocidade = velocidade.normalized() * multiplicador_velocidade

func ta_gritando():
	return $Sprite.visible

func _input(event):
	if event.is_action_released('acao'):
		$Sprite.visible = false

func _physics_process(delta):
	if animador.current_animation == 'squash' and animador.is_playing():
		return
	if _movendo and animador.current_animation == 'idle':
		animador.play("andar")
	elif (not _movendo):
		rotation_degrees = 0
		animador.play("idle")
	velocidade = move_and_slide(velocidade)


func _on_alavanca_de_toque_alavanca_movida(posicao: Vector2):
	if not $BobAndando.playing:
		$BobAndando.play()
	velocidade = posicao.normalized() * multiplicador_velocidade
	move_and_slide(velocidade)
	animador.play("andar")
	_movendo = true


func _on_alavanca_de_toque_alavanca_solta():
	$BobAndando.stop()
	velocidade = Vector2.ZERO
	_movendo = false
