extends KinematicBody

const sfx_impacto = preload("res://elementos/audio/sfx/obstaculos/dano-poste.mp3")

const sfx := [
	preload("res://elementos/audio/sfx/chefe/dano-tentaculo-1.mp3"),
	preload("res://elementos/audio/sfx/chefe/dano-tentaculo-2.mp3"),
	preload("res://elementos/audio/sfx/chefe/dano-tentaculo-3.mp3")
]

onready var tentaculo_anim = $Sprite3D/AnimationPlayer
onready var sfx_player := get_node("/root/Enchente/AudioStreamSFX") as AudioStreamPlayer

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

func tocar_som_impacto(imune: bool):
	if not sfx:
		return
	if imune:
		sfx_player.pitch_scale = 3.0
		sfx_player.volume_db = -10.0
		sfx_player.stream = sfx_impacto
	else:
		sfx_player.pitch_scale = 1.0
		sfx_player.volume_db = 0.0
		sfx_player.stream = sfx[randi() % sfx.size()]
	sfx_player.play()
