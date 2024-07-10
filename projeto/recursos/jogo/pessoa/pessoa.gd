extends KinematicBody2D
class_name Pessoa


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var variedade_distancia_maxima: Vector2 = Vector2(50,100)
export var variedade_aleatorio: int = 200

var aleatorio = RandomNumberGenerator.new()
var _alvo: KinematicBody2D
var distancia_maxima: int

onready var vetor_diferente: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	aleatorio.randomize()
	distancia_maxima = aleatorio.randi_range(variedade_distancia_maxima.x,variedade_distancia_maxima.y)
	vetor_diferente = gerar_vetor_aleatorio()

func gerar_vetor_aleatorio():
	return Vector2(
		aleatorio.randf_range(-variedade_aleatorio, variedade_aleatorio),
		aleatorio.randf_range(-variedade_aleatorio, variedade_aleatorio))

func definir_alvo(alvo):
	_alvo = alvo
	var temporizador = Timer.new()
	$Pop.play()
	temporizador.connect("timeout", self, "desligar_pop")
	temporizador.wait_time = $Pop.stream.get_length()
	add_child(temporizador)
	temporizador.autostart = true

func desligar_pop():
	$Pop.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not _alvo:
		return

	var distancia = (_alvo.position - position) + vetor_diferente
	var vetor_movimento = distancia.normalized() * (distancia.length_squared() / (distancia_maxima ^ 2))

	move_and_slide(vetor_movimento)
