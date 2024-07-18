extends CanvasLayer

onready var card_img: TextureRect = $PainelDescricao/ImgCard
onready var desc_avanc: Label = $PainelDescricao/Desc
onready var btn_jogar = $PainelDescricao/Jogar
onready var btn_saiba_menos = $PainelDescricao/SaibaMenos

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

func _on_Jogar_pressed():
	var botao_jogar_tween = $PainelDescricao/Jogar/TweenJogar

	botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
	botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)
	botao_jogar_tween.start()

func _on_SaibaMenos_pressed():
	self.queue_free()

func _on_TweenJogar_tween_completed(object, key):
	if E_jogavel:
		TrocadorDeCenas.trocar_cena(Cena_do_jogo)
	self.queue_free()
