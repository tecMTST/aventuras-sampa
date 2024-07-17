extends Node2D


export var maximo := 10
export var valor := 0


onready var texo = $Texto as RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	texo.bbcode_text = "[center]%s/%s[/center]" % [valor, maximo]


func alterar_valor(novo_valor: int):
	valor = novo_valor
	texo.bbcode_text = "[center]%s/%s[/center]" % [valor, maximo]


func alterar_maximo(novo_maximo: int):
	maximo = novo_maximo
	texo.bbcode_text = "[center]%s/%s[/center]" % [valor, maximo]
