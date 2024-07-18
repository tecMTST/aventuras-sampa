tool
extends Control

export var JsonCards = 'res://recursos/feed_de_noticias/Cards.json'
export var idCard = "Teste"
export var Imagem_card: StreamTexture
export var E_jogavel: bool
export var Cena_do_jogo: String

onready var card_img: TextureRect = $ImgCard
onready var titulo_texto: RichTextLabel = $PainelPrincipal/Titulo
onready var desc_basica: Label = $PainelPrincipal/Desc
onready var animacao_coracao: AnimationPlayer = $AnimationCoracao
onready var botao_saibaMais = $PainelPrincipal/SaibaMais
onready var painelSaibaMais = load("res://recursos/feed_de_noticias/PainelSaibaMais.tscn")

var saiba_mais_apertado: bool = false
var coracao_apertado: bool = false
var Titulo: String
var Descricao_basica: String
var Descricao_avancada: String

func _atualizador_de_card():
	var instanciaSaibaMais = painelSaibaMais.instance()
	var valoresNoDict = loadJson(JsonCards)
	var valoresId = valoresNoDict.get(String(idCard))

	card_img.texture = Imagem_card
	instanciaSaibaMais.Imagem_card = Imagem_card
	instanciaSaibaMais.E_jogavel = E_jogavel
	instanciaSaibaMais.Cena_do_jogo = Cena_do_jogo

	# Extrai valores específicos do cartão
	Titulo = valoresId.get("Titulo")
	titulo_texto.bbcode_text = Titulo
	Descricao_basica = valoresId.get("DescricaoBasica")
	desc_basica.text = Descricao_basica
	Descricao_avancada = valoresId.get("DescricaoAvancada")
	instanciaSaibaMais.Descricao_avancada = Descricao_avancada

	return instanciaSaibaMais

func _ready():
	_atualizador_de_card()

func _tocar_animacao_coracao():
	if coracao_apertado == false:
		animacao_coracao.play("Animação")
		yield(animacao_coracao, "animation_finished")
		coracao_apertado = true
	else:
		animacao_coracao.play_backwards("Animação")
		yield(animacao_coracao, "animation_finished")
		coracao_apertado = false

func _on_SaibaMais_pressed():
	var botao_tween = $Tween
	
	if not saiba_mais_apertado:
		botao_tween.interpolate_property(botao_saibaMais, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_ELASTIC)
		botao_tween.interpolate_property(botao_saibaMais, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_ELASTIC)
		botao_tween.start()

func _acao_SaibaMais():
	var instanciaSaibaMais = _atualizador_de_card()
	if saiba_mais_apertado:
		get_tree().get_root().add_child(instanciaSaibaMais)


func _on_coracaobotao_pressed():
	_tocar_animacao_coracao()

func loadJson(nomejson):
	var arquivo = File.new()
	if arquivo.file_exists(nomejson):
		arquivo.open(nomejson, arquivo.READ)
		var conteudo = parse_json(arquivo.get_as_text())
		if conteudo == null:
			print("Could not parse " + nomejson + " as JSON." + \
			"Porfavor cheque se o path está certo.")
		#print(conteudo)
		return conteudo
	else:
		print("File Open Error: could not open file " + nomejson)
	arquivo.close()


func _on_Tween_tween_completed(object, key):
	saiba_mais_apertado = true
	_acao_SaibaMais()
	saiba_mais_apertado = false
