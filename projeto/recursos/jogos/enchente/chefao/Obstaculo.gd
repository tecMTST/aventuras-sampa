extends KinematicBody

const sfx_impacto = preload("res://elementos/audio/sfx/obstaculos/dano-poste.mp3")

export var velocidade = 15.0

onready var sfx_player := get_node("/root/Enchente/AudioStreamSFX") as AudioStreamPlayer

func _physics_process(delta: float) -> void:
	move_and_slide(Vector3(0, 0, velocidade * EnchenteEstadoDeJogo.VelocidadeGlobal), Vector3.UP)

func tocar_som_impacto(imune: bool):
	if imune:
		sfx_player.pitch_scale = 3.0
		sfx_player.volume_db = -10.0
		sfx_player.stream = sfx_impacto
	else:
		sfx_player.pitch_scale = 1.0
		sfx_player.volume_db = 0.0
		sfx_player.stream = sfx_impacto
	sfx_player.play()
