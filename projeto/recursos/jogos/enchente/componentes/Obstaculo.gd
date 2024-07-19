class_name Obstaculo
extends KinematicBody

export var velocidade := 1000.0
export var textura: Texture

func _ready() -> void:
	$Sprite3D.texture = textura

func _process(delta):
	move_and_slide(Vector3(0, 0, velocidade * EnchenteEstadoDeJogo.VelocidadeGlobal * delta), Vector3.UP)

func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
