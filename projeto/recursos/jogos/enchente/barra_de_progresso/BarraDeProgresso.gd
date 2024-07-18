extends Control


export var minutos: float = 5

signal tempo_acabado

onready var tempo = Timer.new()
onready var barra = $ProgressoDeTextura

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(tempo)
	tempo.one_shot = true
	tempo.wait_time = 60 * minutos
	tempo.connect("timeout", self, "_ao_tempo_acabar")


func iniciar():
	tempo.start()


func _process(delta):
	barra.value = 2 * barra.rect_size.x * (1 - tempo.time_left / tempo.wait_time)


func _ao_tempo_acabar():
	emit_signal("tempo_acabado")
