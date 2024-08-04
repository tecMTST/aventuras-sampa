extends KinematicBody

onready var tweendescida: Tween = $Sprite3D/Descida
onready var tweensubida: Tween = $Sprite3D/Subida

func _ready():
	$CollisionShape.disabled = true
	tweensubida.interpolate_property($Sprite3D, "translation",
		Vector3(0.202, -1.828, 0.041), Vector3(0.202, 1.671, 0.041), 0.9,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweensubida.start()

func _on_Timer_timeout():
	tweendescida.interpolate_property($Sprite3D, "translation",
		Vector3(0.202, 1.671, 0.041), Vector3(0.202, -1.828, 0.041), 0.9,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CollisionShape.disabled = true
	tweendescida.start()

func _on_Descida_tween_completed(object, key):
	self.queue_free()

func _on_Subida_tween_completed(object, key):
	$CollisionShape.disabled = false

func _on_AreaColetoraObstaculos_body_entered(body):
	if body.is_in_group("minasAquaticas"):
		body.queue_free()
