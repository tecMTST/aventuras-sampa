extends Node2D

onready var texto_1 = $Tela1/Texto1
onready var texto_2 = $Tela1/Texto2
onready var texto_3 = $Tela1/Texto3
onready var dialog_container = $ContainerDialogo/DialogContainer
onready var garoa = $Garoa
onready var chuva = $Chuva
onready var enchurrada = $Enchurrada

onready var tela_1 = $Tela1
onready var tela_2 = $Tela2
onready var tela_3 = $Tela3
onready var tela_4 = $Tela4
onready var botao_avancar = $Botoes/BotaoAvancar
onready var botao_pular = $Botoes/BotaoPular

var tempo_entre_pontos : float = 1
var tempo_entre_efeitos : float = 3
var ponto_atual = 1

func _ready():
	var time = Time.get_datetime_dict_from_system()
	texto_2.definir_texto(str(time["day"]) + "/" + str(time["month"]) + "/" +  str(time["year"]) 
							+ " - " + str(time["hour"]) + ":" + str(time["minute"]))

func proximo_ponto():
	ponto_atual = ponto_atual + 1
	match ponto_atual:	
		2:
			texto_2.iniciar()
		3:
			texto_3.iniciar()
		4:
			botao_avancar.visible = false
			botao_pular.visible = false
			yield(get_tree().create_timer(tempo_entre_pontos), "timeout")
			var dialog = Dialogic.start("enchente-cutscene")
			dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
			dialog_container.add_child(dialog)
			tela_1.visible = false

func avancar():
	texto_1.finalizar()
	texto_2.finalizar()
	texto_3.finalizar()
	ponto_atual = 3	
	proximo_ponto()

func fim():
	TrocadorDeCenas.trocar_cena("res://recursos/jogos/enchente/cenas/Enchente.tscn")

func _on_dialogic_signal(arg):
	match arg:	
		"fim":
			fim()
		"saco":
			garoa.visible = false
			chuva.visible = false
			enchurrada.visible = false
			tela_2.visible = false	
		"saco_dona_maria":
			tela_3.visible = false
		"enchurrada":			
			enchurrada.visible = true
			yield(get_tree().create_timer(tempo_entre_efeitos), "timeout")
			garoa.visible = false
			chuva.visible = false
		"chuva":
			chuva.visible = true
			yield(get_tree().create_timer(tempo_entre_efeitos), "timeout")
			garoa.visible = false
			enchurrada.visible = false
		"garoa":
			garoa.visible = true	
			yield(get_tree().create_timer(tempo_entre_efeitos), "timeout")
			chuva.visible = false
			enchurrada.visible = false
