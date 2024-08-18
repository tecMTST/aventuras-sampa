extends Control

onready var desc_avanc: RichTextLabel = $CanvasLayer/PainelDescricao/Desc
onready var btn_jogar: TextureButton = $CanvasLayer/PainelDescricao/Jogar
onready var btn_saiba_menos: TextureButton = $CanvasLayer/PainelDescricao/SaibaMenos
onready var botao_jogar_tween: Tween = $CanvasLayer/PainelDescricao/Jogar/TweenJogar
onready var botao_SaibaMenos_tween: Tween = $CanvasLayer/PainelDescricao/SaibaMenos/TweenSaibaMenos
onready var TweenPainel: Tween = $CanvasLayer/PainelDescricao/TweenPainel
onready var PainelDescricao = $CanvasLayer/PainelDescricao
onready var lugar_na_tela = $CanvasLayer/PainelDescricao.rect_global_position.x

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

	desc_avanc.text = Descricao_avancada

	TweenPainel.interpolate_property(PainelDescricao, "rect_position", Vector2(lugar_na_tela, 1350), Vector2(lugar_na_tela, 498), 1.4, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	TweenPainel.start()

func _auto_deletar():
	if saiba_menos_apertado:
		self.queue_free()

func _on_SaibaMenos_button_up():
	botao_SaibaMenos_tween.start()
	botao_SaibaMenos_tween.interpolate_property(btn_saiba_menos, "rect_scale", Vector2(1.175, 0.695), Vector2(1.25, 0.74), 0.1, Tween.TRANS_ELASTIC)
	botao_SaibaMenos_tween.interpolate_property(btn_saiba_menos, "rect_scale", Vector2(1.25, 0.74), Vector2(1.175, 0.695), 0.1, Tween.TRANS_ELASTIC)
	saiba_menos_apertado = true
	TweenPainel.interpolate_property(PainelDescricao, "rect_position", Vector2(lugar_na_tela, 498), Vector2(lugar_na_tela, 1350), 1.4, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	TweenPainel.start()
	yield(TweenPainel, "tween_completed")
	_auto_deletar()

func _on_Jogar_button_up():
	botao_jogar_tween.start()
	botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
	botao_jogar_tween.interpolate_property(btn_jogar, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)
	yield(botao_jogar_tween, "tween_completed")
	TrocadorDeCenas.trocar_cena(Cena_do_jogo)
	self.queue_free()
