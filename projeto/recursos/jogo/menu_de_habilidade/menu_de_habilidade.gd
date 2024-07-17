extends Node2D


export var loc_jogador: NodePath


onready var botao = $Mostrar
onready var menu = $Menu
onready var jogador = get_node(loc_jogador) as Jogador
onready var texto_pontos = $Mostrar/Pontos as RichTextLabel


func _on_Mostrar_pressed():
	menu.visible = not menu.visible


func _process(delta):
	texto_pontos.bbcode_text = "[center]%s[/center]" % jogador.pontos_de_habilidade


func _on_Area_pressed():
	jogador.aumentar_area(5)


func _on_NumeroDePessoas_pressed():
	jogador.aumentar_maximo_seguidores(5)
