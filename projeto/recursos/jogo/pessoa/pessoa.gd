extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var variedade_distancia_maxima: Vector2 = Vector2(50,100)
export var variedade_aleatorio: int = 200

var aleatorio = RandomNumberGenerator.new()
var alvo: KinematicBody2D
var distancia_maxima: int

onready var vetor_diferente: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	aleatorio.randomize()
	distancia_maxima = aleatorio.randi_range(variedade_distancia_maxima.x,variedade_distancia_maxima.y)
	vetor_diferente = Vector2(
		aleatorio.randf_range(-variedade_aleatorio, variedade_aleatorio),
		aleatorio.randf_range(-variedade_aleatorio, variedade_aleatorio))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not alvo:
		return
	
	var distancia = (alvo.position - position) + vetor_diferente
	
	move_and_slide(distancia.normalized() * (distancia.length_squared() / (distancia_maxima ^ 2)))


func _on_Area_body_entered(body: KinematicBody2D):
	if not body.ta_gritando():
		return
	alvo = body
