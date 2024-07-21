extends Control

onready var card_img: TextureRect = $PainelSaibaMais/PainelDescricao/ImgCard
onready var desc_avanc: Label = $PainelSaibaMais/PainelDescricao/Desc
onready var btn_jogar = $PainelSaibaMais/PainelDescricao/Jogar
onready var btn_saiba_menos = $PainelSaibaMais/PainelDescricao/SaibaMenos
onready var botao_jogar_tween = $PainelSaibaMais/PainelDescricao/Jogar/TweenJogar
onready var botao_SaibaMenos_tween = $PainelSaibaMais/PainelDescricao/SaibaMenos/TweenSaibaMenos

var Descricao_avancada: String
var Imagem_card: StreamTexture
var E_jogavel: bool
var Cena_do_jogo: String

func _ready():
	if E_jogavel:
		btn_jogar.visible = true
	else:
		btn_jogar.visible = false

	card_img.texture = Imagem_card
	desc_avanc.text = Descricao_avancada

func _on_TweenSaibaMenos_tween_completed(object, key):
	self.queue_free()

func _on_TweenJogar_tween_completed(object, key):
	TrocadorDeCenas.trocar_cena(Cena_do_jogo)
	self.queue_free()

func _on_SaibaMenos_toggled(button_pressed):
	botao_SaibaMenos_tween.start()
	botao_SaibaMenos_tween.interpolate_property(btn_saiba_menos, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
	botao_SaibaMenos_tween.interpolate_property(btn_saiba_menos, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)

func _on_Panel_gui_input(event):
	if event is InputEventScreenTouch:
		botao_jogar_tween.start()
		botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
		botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)
