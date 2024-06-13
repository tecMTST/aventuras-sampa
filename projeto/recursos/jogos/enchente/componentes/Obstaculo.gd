extends KinematicBody

export var velocidade = 500.0

func _process(delta):
	move_and_slide(Vector3(0, 0, velocidade * delta * EnchenteEstadoDeJogo.VelocidadeGlobal), Vector3.UP)
