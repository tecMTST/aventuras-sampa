extends KinematicBody
class_name Obstaculo

export var velocidade := 1000.0
export var textura: Texture
var sfx: AudioStream
var info: Dictionary

func _ready() -> void:
	$Sprite3D.texture = textura
	$SfxImpacto.stream = sfx

func _process(delta):
	move_and_slide(Vector3(0, 0, velocidade * EnchenteEstadoDeJogo.VelocidadeGlobal * delta), Vector3.UP)

func tocar_som_impacto():
	$SfxImpacto.stop()
	$SfxImpacto.play()

func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
