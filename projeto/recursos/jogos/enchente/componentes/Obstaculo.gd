extends KinematicBody

export var velocidade = 15.0

func _process(delta):
	move_and_slide(Vector3(0, 0, velocidade * EnchenteEstadoDeJogo.VelocidadeGlobal), Vector3.UP)
