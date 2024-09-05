extends KinematicBody

onready var tentaculo_anim = $Sprite3D/AnimationPlayer

func _ready():
	$CollisionShape.disabled = true
	tentaculo_anim.play("In_OUt")
	yield(tentaculo_anim, "animation_finished")
	$CollisionShape.disabled = false
	tentaculo_anim.play("Idle")
	$Timer.start(5)
	yield($Timer, "timeout")
	tentaculo_anim.play_backwards("In_OUt")
	yield(tentaculo_anim, "animation_finished")
	self.queue_free()

func _on_AreaColetoraObstaculos_body_entered(body):
	if body.is_in_group("minasAquaticas"):
		body.queue_free()
