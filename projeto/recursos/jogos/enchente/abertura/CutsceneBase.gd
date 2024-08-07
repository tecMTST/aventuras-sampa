extends Node2D

onready var texto_1 = $Tela1/Texto1
onready var texto_2 = $Tela1/Texto2
onready var texto_3 = $Tela1/Texto3
onready var texto_4 = $Tela2/Texto4
onready var texto_5 = $Tela2/Texto5
onready var texto_6 = $Tela2/Texto6

onready var tela_1 = $Tela1
onready var tela_2 = $Tela2
onready var tela_3 = $Tela3
onready var tela_4 = $Tela4
onready var botao_avancar = $Botoes/BotaoAvancar

var tempo_entre_pontos : float = 1
var ponto_atual = 1

func proximo_ponto():
	ponto_atual = ponto_atual + 1
	match ponto_atual:	
		2:
			texto_2.iniciar()
		3:
			texto_3.iniciar()
		4:
			yield(get_tree().create_timer(tempo_entre_pontos), "timeout")			
			tela_1.visible = false
			texto_4.visible = true
			texto_4.iniciar()
		5:
			yield(get_tree().create_timer(tempo_entre_pontos), "timeout")			
			texto_4.visible = false
			texto_5.visible = true
			texto_5.iniciar()
		6:
			yield(get_tree().create_timer(tempo_entre_pontos), "timeout")			
			texto_5.visible = false
			texto_6.visible = true
			texto_6.iniciar()
		7:
			pass
		8:
			fim()
	botao_avancar.visible = true

func avancar():
	botao_avancar.visible = false
	match ponto_atual:	
		1:
			texto_1.finalizar()
			texto_2.finalizar()
			texto_3.finalizar()
			ponto_atual = 3
			proximo_ponto()
		2:
			texto_1.finalizar()
			texto_2.finalizar()
			texto_3.finalizar()
			ponto_atual = 3
			proximo_ponto()
		3:
			texto_1.finalizar()
			texto_2.finalizar()
			texto_3.finalizar()
			ponto_atual = 3
			proximo_ponto()
		4:
			texto_4.finalizar()
			proximo_ponto()
		5:
			texto_5.finalizar()
			proximo_ponto()
		6:
			texto_6.finalizar()
			proximo_ponto()
		7:
			pass

func fim():
	pass

