tool
extends Control

export var JsonCards = 'res://recursos/feed_de_noticias/Cards.json'
export var idCard = "Teste"
export var Imagem_card: StreamTexture
export var E_jogavel: bool
export var Cena_do_jogo: String

onready var card_img: TextureRect = $PainelPrincipal/ImgCard
onready var card_2: TextureRect = $PainelHidden/outline3/ImgCard2
onready var titulo_texto: RichTextLabel = $PainelPrincipal/Titulo
onready var desc_basica: Label = $PainelPrincipal/Desc
onready var animacao_coracao: AnimationPlayer = $AnimationCoracao
onready var botao_saibaMais = $PainelPrincipal/SaibaMais

var saiba_mais_apertado: bool = false
var coracao_apertado: bool = false
var Titulo: String
var Descricao_basica: String
var Descricao_avancada: String
var quantidade_de_paineis = 0

func _atualizar_card():
	var valoresNoDict = loadJson(JsonCards)
	var valoresId = valoresNoDict.get(String(idCard))

	card_img.texture = Imagem_card
	card_2.texture = Imagem_card

	# Extrai valores específicos do cartão
	Titulo = valoresId.get("Titulo")
	titulo_texto.bbcode_text = Titulo
	Descricao_basica = valoresId.get("DescricaoBasica")
	desc_basica.text = Descricao_basica
	Descricao_avancada = valoresId.get("DescricaoAvancada")

func _atualizar_painel():
	var painelSaibaMais = load("res://recursos/feed_de_noticias/PainelSaibaMais.tscn")
	var instanciaSaibaMais = painelSaibaMais.instance()
	var valoresNoDict = loadJson(JsonCards)
	var valoresId = valoresNoDict.get(String(idCard))

	instanciaSaibaMais.E_jogavel = E_jogavel
	instanciaSaibaMais.Cena_do_jogo = Cena_do_jogo

	# Extrai valores específicos para o painel
	Descricao_avancada = valoresId.get("DescricaoAvancada")
	instanciaSaibaMais.Descricao_avancada = Descricao_avancada

	get_tree().root.add_child(instanciaSaibaMais)

func _ready():
	recarregar_like()
	_atualizar_card()

func recarregar_like():
	if not Salvamento.existe("like", idCard):
		print('Não possue like')
		save_like()
	else:
		var save = Salvamento.carregar_tudo("like")
		var dados = save.Dados
		print(dados)

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

	yield(botao_tween, "tween_completed")
	_atualizar_painel()

func _on_coracaobotao_pressed():
	var coracao_tween = $PainelPrincipal/Coracao/TweenCoracao
	coracao_tween.interpolate_property($PainelPrincipal/Coracao, "scale", Vector2(1.907, 1.907), Vector2(2, 2), 0.2, Tween.TRANS_ELASTIC)
	coracao_tween.interpolate_property($PainelPrincipal/Coracao, "scale", Vector2(2, 2), Vector2(1.907, 1.907), 0.2, Tween.TRANS_ELASTIC)
	coracao_tween.start()
	_tocar_animacao_coracao()

func save_like():
	Salvamento.salvar("like", idCard, coracao_apertado)

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
