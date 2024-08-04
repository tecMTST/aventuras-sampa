extends Control

onready var card_img: TextureRect = $PainelSaibaMais/PainelDescricao/ImgCard
onready var desc_avanc: Label = $PainelSaibaMais/PainelDescricao/Desc
onready var btn_jogar = $PainelSaibaMais/PainelDescricao/Jogar
onready var btn_saiba_menos = $PainelSaibaMais/PainelDescricao/SaibaMenos
onready var botao_jogar_tween = $PainelSaibaMais/PainelDescricao/Jogar/TweenJogar
onready var botao_SaibaMenos_tween = $PainelSaibaMais/PainelDescricao/SaibaMenos/TweenSaibaMenos
onready var TweenFundo = $PainelSaibaMais/Fundo/TweenFundo
onready var TweenPainel = $PainelSaibaMais/PainelDescricao/TweenPainel
onready var animationplayer = $PainelSaibaMais/AnimationPlayer
#onready var Fundo = $PainelSaibaMais/Fundo
#onready var PainelDescricao = $PainelSaibaMais/PainelDescricao

var Descricao_avancada: String
var Imagem_card: StreamTexture
var E_jogavel: bool
var Cena_do_jogo: String
var saiba_menos_apertado = false

func _ready():
	if E_jogavel:
		btn_jogar.visible = true
	else:
		btn_jogar.visible = false

	card_img.texture = Imagem_card
	desc_avanc.text = Descricao_avancada
	animationplayer.play("Subindo")

func _on_TweenJogar_tween_completed(object, key):
	TrocadorDeCenas.trocar_cena(Cena_do_jogo)
	self.queue_free()

func _on_Panel_gui_input(event):
	if event is InputEventScreenTouch:
		botao_jogar_tween.start()
		botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
		botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)

func _auto_deletar():
	if saiba_menos_apertado:
		yield(animationplayer, "animation_finished")
		self.queue_free()

func _on_SaibaMenos_button_up():
	botao_SaibaMenos_tween.start()
	botao_SaibaMenos_tween.interpolate_property(btn_saiba_menos, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
	botao_SaibaMenos_tween.interpolate_property(btn_saiba_menos, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)
	saiba_menos_apertado = true
	animationplayer.play_backwards("Subindo")
	_auto_deletar()
#	TweenPainel.interpolate_property(PainelDescricao, "rect_position", Vector2(360, 277), Vector2(360, 1470), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
#	TweenPainel.start()
#	yield(TweenPainel, "tween_completed")
#	TweenFundo.interpolate_property(Fundo, "rect_position", Vector2(360, 3), Vector2(360, 1326), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
#	TweenFundo.start()
