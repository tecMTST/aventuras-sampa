extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var multiplicador_velocidade = 500

onready var corpo = $Corpo as KinematicBody2D
onready var animador = $Corpo/Animador as AnimationPlayer
onready var sprite = $Corpo/SpritesJogador as AnimatedSprite

var velocidade = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	animador.play("idle")

func get_input():
	velocidade = Vector2()
	var movendo = false
	if Input.is_action_pressed("right"):
		sprite.scale.x = 1
		velocidade.x += 1
		movendo = true
	if Input.is_action_pressed("left"):
		sprite.scale.x = -1
		velocidade.x -= 1
		movendo = true
	if Input.is_action_pressed("down"):
		velocidade.y += 1
		movendo = true
	if Input.is_action_pressed("up"):
		velocidade.y -= 1
		movendo = true
	velocidade = velocidade.normalized() * multiplicador_velocidade
	return movendo

func _physics_process(delta):
	var movendo = get_input()
	if movendo and animador.current_animation == 'idle':
		animador.play("andar")
	elif (not movendo) and animador.current_animation == 'andar':
		corpo.rotation_degrees = 0
		animador.play("idle")
	velocidade = corpo.move_and_slide(velocidade)
