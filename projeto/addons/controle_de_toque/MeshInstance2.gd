extends MeshInstance

var toque_de_entrada = false
var position3d = Vector3.ZERO

func _physics_process(delta):
	if toque_de_entrada:
		self.rotation_degrees = position3d


func _on_ControleDeSwipe_toque_realizado(historico):
	toque_de_entrada = true


func _on_ControleDeSwipe_toque_desfeito(historico):
	toque_de_entrada = false


func _on_ControleDeSwipe_arrastar_realizado(historico: PoolVector2Array):
	var v1 = historico[0]
	var v2 = historico[-1]
	var v_novo = v2 - v1 / 2
	position3d.x = v_novo.y
	position3d.y = v_novo.x
