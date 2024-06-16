tool
extends Control

export var Titulo: String
export var Descricao_basica: String
export var Descricao_avancada: String
export var Imagem_card: StreamTexture
export var E_jogavel: bool
export var Cena_do_jogo: String

onready var card_img: TextureRect = $ImgCard
onready var titulo_texto: RichTextLabel = $PainelPrincipal/Titulo
onready var desc_basica: Label = $PainelPrincipal/Desc

onready var titulo_desc: RichTextLabel = $PainelDescricao/Titulo
onready var desc_img: TextureRect = $ImgCard 
onready var desc_avancada: Label = $PainelDescricao/Desc
onready var botao_jogar: TextureButton = $PainelDescricao/Jogar

func _atualizador_de_card():
	# Parte Frontal do card
	titulo_texto.bbcode_text = Titulo
	titulo_desc.bbcode_text = Titulo
	card_img.texture = Imagem_card
	
	# Parte da Descrição
	desc_img.texture = Imagem_card
	desc_basica.text = Descricao_basica
	desc_avancada.text = Descricao_avancada
	if E_jogavel:
		botao_jogar.visible = true
	else:
		botao_jogar.visible = false

func _ready():
	_atualizador_de_card()

func _on_Jogar_pressed():
	if E_jogavel:
		TrocadorDeCenas.trocar_cena(Cena_do_jogo)
