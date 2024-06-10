extends KinematicBody

export var velocidade = 400.0

func _process(delta):
	move_and_slide(Vector3(0, 0, velocidade * delta), Vector3.UP)
