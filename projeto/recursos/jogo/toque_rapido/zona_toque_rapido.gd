extends Area2D


export var fabrica_seguidores: NodePath
export var jogador: NodePath
export var toques_para_mais_um_seguidor := 5
export var tempo_segundos := 5
export var toques_necessarios := 40

onready var progresso_toque = $ProgressoToque as ProgressBar
onready var contador_tempo = $ContadorTempo as RichTextLabel
onready var temporizador = $Temporizador as Timer
onready var registrador_toque = $registrador_toque
onready var _fabrica = get_node(fabrica_seguidores)
onready var _jogador = get_node(jogador)

# Called when the node enters the scene tree for the first time.
func _ready():
	progresso_toque.max_value = registrador_toque.quantidade_de_toques
	registrador_toque.tempo_segundos = tempo_segundos
	registrador_toque.quantidade_de_toques = toques_necessarios


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progresso_toque.value = registrador_toque.toques_realizados()
	contador_tempo.text = String(floor(temporizador.time_left))


func _on_zona_toque_rapido_body_entered(body):
	if body.name != 'jogador':
		return
	registrador_toque.inicializar()


func _on_registrador_toque_toque():
	_jogador.toque()
	if registrador_toque.toques_realizados() % toques_para_mais_um_seguidor == 0:
		_fabrica.adicionar_seguidores(_jogador, 1)


func _on_registrador_toque_finalizado(sucesso):
	visible = false
	_fabrica.adicionar_seguidores(_jogador, floor(registrador_toque.toques_realizados()/toques_para_mais_um_seguidor))
	#queue_free()
