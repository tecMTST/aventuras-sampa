extends Label

signal Inicio
signal Tecla
signal Fim

export var autostart : bool = false
export var atrasar_inicio : float = 0
export var intervalo : float = 0.2
export var variacao_intervalo : float = 0.1
export var audio : String = ''
export var pitch : float = 1
export var variacao_pitch : float = 0.2
export var volume_db : float = 0

var audio_player : AudioStreamPlayer
var sequencia_texto : String = ''
var indice : int = 0
var timer : float = 0
var ativo : bool = false

func _ready():
	if audio != '':
		audio_player = AudioStreamPlayer.new()
		audio_player.bus = "SFX Menu"
		add_child(audio_player)	
		audio_player.pitch_scale = pitch
		audio_player.volume_db = volume_db
		audio_player.stop()
		var sound = load(audio)
		audio_player.stream = sound
	sequencia_texto = text
	text = ''
	ativo = autostart
	timer = atrasar_inicio

func _process(delta):
	if not ativo:
		return		
	if indice == 1:
		emit_signal("Inicio")
	timer = timer - delta
	if timer <= 0:
		if variacao_intervalo != 0:
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			timer = intervalo + (rng.randf_range((-1*variacao_intervalo), variacao_intervalo))
		else:
			timer = intervalo
		text = text + sequencia_texto[indice]
		indice = indice + 1
		emit_signal("Tecla")
		if audio_player:
			if variacao_pitch != 0:				
				var rng = RandomNumberGenerator.new()
				rng.randomize()
				audio_player.pitch_scale = pitch + (rng.randf_range((-1*variacao_pitch), variacao_pitch))
			audio_player.play()
		if indice >= sequencia_texto.length():
			ativo = false
			timer = 0
			if audio_player:
				audio_player.stream_paused = true
				audio_player.stop()
			emit_signal("Fim")

func definir_texto(texto : String):
	sequencia_texto = texto
	text = ''
						
func iniciar():
	text = ''
	indice = 0
	timer = atrasar_inicio
	ativo = true

func finalizar():
	text = sequencia_texto	
	timer = 0
	ativo = false
	if audio_player:
		audio_player.stream_paused = true
		audio_player.stop()
	emit_signal("Fim")
	
	


