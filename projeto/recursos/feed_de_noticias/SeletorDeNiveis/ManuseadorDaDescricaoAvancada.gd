extends CanvasLayer

onready var card_img: TextureRect = $PainelDescricao/ImgCard
onready var desc_avanc: Label = $PainelDescricao/Desc
onready var btn_jogar = $PainelDescricao/Jogar
onready var btn_saiba_menos = $PainelDescricao/SaibaMenos
onready var botao_jogar_tween = $PainelDescricao/Jogar/TweenJogar
onready var botao_SaibaMenos_tween = $PainelDescricao/SaibaMenos/TweenSaibaMenos
onready var TweenFundo = $Fundo/TweenFundo
onready var TweenPainel = $PainelDescricao/TweenPainel
onready var Fundo = $Fundo
onready var PainelDescricao = $PainelDescricao

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
	
	TweenPainel.interpolate_property(PainelDescricao, "modulate:a", 0, 1, 0.7, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	TweenFundo.interpolate_property(Fundo, "modulate:a", 0, 1, 0.7, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	TweenPainel.start()
	TweenFundo.start()

func _auto_deletar():
	if saiba_menos_apertado:
		self.queue_free()

func _on_SaibaMenos_button_up():
	botao_SaibaMenos_tween.start()
	botao_SaibaMenos_tween.interpolate_property(btn_saiba_menos, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
	botao_SaibaMenos_tween.interpolate_property(btn_saiba_menos, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)
	saiba_menos_apertado = true
	TweenPainel.interpolate_property(PainelDescricao, "modulate:a", 1, 0, 0.7, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	TweenFundo.interpolate_property(Fundo, "modulate:a", 1, 0, 0.7, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	TweenPainel.start()
	TweenFundo.start()
	yield(TweenFundo, "tween_completed")
	_auto_deletar()

func _on_Jogar_button_up():
	botao_jogar_tween.start()
	botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
	botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)
	yield(botao_jogar_tween, "tween_completed")
	TrocadorDeCenas.trocar_cena(Cena_do_jogo)
	self.queue_free()
