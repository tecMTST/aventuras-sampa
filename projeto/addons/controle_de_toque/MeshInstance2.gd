extends MeshInstance

var toque_de_entrada = false
var y_1
var y_2
var x_1
var x_2
var position3d = Vector3.ZERO

func _physics_process(delta):
	if toque_de_entrada:
		self.rotation_degrees = position3d

func _on_ControleDeSwipe_toque_realizado(foi_toque_realizado):
	toque_de_entrada = foi_toque_realizado


func _on_ControleDeSwipe_toque_desfeito(foi_toque_realizado):
	toque_de_entrada = foi_toque_realizado


func _on_ControleDeSwipe_coordenadas_de_toque_y(coordenadas_y):
	y_1 = coordenadas_y.front()
	y_2 = coordenadas_y.back()
	var calculo = y_1 - y_2 / 2
	position3d.x = calculo


func _on_ControleDeSwipe_coordenadas_de_toque_x(coordenadas_x):
	x_1 = coordenadas_x.front()
	x_2 = coordenadas_x.back()
	var calculo = x_1 - x_2 / 2
	position3d.y = calculo
