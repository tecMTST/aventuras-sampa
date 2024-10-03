extends KinematicBody
class_name Obstaculo

enum TIPO {TERRESTRE, AEREO, RAMPA, ITEM}

export var cores : PoolColorArray = []
export var velocidade := 1000.0
export var textura: Texture
var sfx: AudioStream
var info: Dictionary

onready var sprite := $Sprite3D as Sprite3D
onready var tween = $Tween as Tween
var cor_padrao := Color.white
var cor_adicional : Color

func _ready() -> void:
	$Sprite3D.texture = textura
	$SfxImpacto.stream = sfx
	var tipo = TIPO.TERRESTRE
	if "aereo" in info["grupos"]:
		tipo = TIPO.AEREO
	elif "rampa" in info["grupos"]:
		tipo = TIPO.RAMPA
	elif "item" in info["grupos"]:
		tipo = TIPO.ITEM

	cor_adicional = cores[tipo]
	tween.interpolate_property(sprite, 'modulate', cor_padrao, cor_adicional, 2.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(sprite, 'modulate', cor_adicional, cor_padrao, 2.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func _physics_process(delta: float) -> void:
	move_and_slide(Vector3(0, 0, velocidade * EnchenteEstadoDeJogo.VelocidadeGlobal * delta), Vector3.UP)

func tocar_som_impacto():
	$SfxImpacto.stop()
	$SfxImpacto.play()

func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
