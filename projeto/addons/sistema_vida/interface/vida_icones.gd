extends Control

export(NodePath) var componente_com_vida
export(Texture) var textura_icone
export var tamanho_icone := 32.0

onready var vida := get_node(componente_com_vida).vida as Vida
onready var icone := TextureRect.new()
onready var icones := $Vidas as HBoxContainer

func _ready() -> void:
	icone.texture = textura_icone
	icone.expand = true
	icone.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icone.rect_min_size = Vector2(tamanho_icone, tamanho_icone)
	_vida_maxima_alterada(Vida.VidaMaximaAlterada.new(0, vida.vida_maxima))

	vida.connect('vida_alterada', self, '_vida_alterada')

func _vida_maxima_alterada(vida_maxima_alterada: Vida.VidaMaximaAlterada) -> void:
	if vida_maxima_alterada.diferenca > 0:
		for _i in range(vida_maxima_alterada.diferenca):
			icones.add_child(icone.duplicate())
	else:
		for _i in range( - vida_maxima_alterada.diferenca):
			icones.remove_child(icone)

func _vida_alterada(vida_alterada: Vida.VidaAlterada) -> void:
	for icone_vida in icones.get_children():
		icone_vida.visible = icone_vida.get_index() < vida_alterada.vida_atual
