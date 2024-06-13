class_name Vida, "vida.svg"
extends Node

signal vida_alterada(alteracao)
signal vida_maxima_alterada(alteracao)
signal vida_acabou

export(float) var vida_maxima = 100.0 setget _set_vida_maxima, _get_vida_maxima
var vida_atual := 0.0 setget _set_vida_atual, _get_vida_atual
var morto := false setget , _get_morto

func _init() -> void:
	vida_atual = vida_maxima

func _set_vida_maxima(p_maxima: float) -> void:
	var vida_maxima_anterior: float = vida_maxima
	vida_maxima = p_maxima
	emit_signal("vida_maxima_alterada", VidaMaximaAlterada.new(vida_maxima_anterior, vida_maxima))
	if (vida_atual > vida_maxima):
		self.vida_atual = vida_maxima

func _get_vida_maxima() -> float:
	return vida_maxima

func _set_vida_atual(p_vida: float) -> void:
	var vida_anterior := vida_atual
	vida_atual = p_vida
	var vida_alterada := VidaAlterada.new(
		vida_anterior,
		vida_atual,
		vida_maxima,
		porcentagem_vida(),
		vida_anterior <= vida_atual
	)
	emit_signal("vida_alterada", vida_alterada)

func _get_vida_atual() -> float:
	return vida_atual

func _get_morto() -> bool:
	return morto

func receber_dano(dano: float) -> void:
	self.vida_atual = max(vida_atual - dano, 0.0)
	if vida_atual == 0.0:
		emit_signal("vida_acabou")

func curar(cura: float) -> void:
	self.vida_atual = min(vida_atual + cura, vida_maxima)

func curar_totalmente() -> void:
	self.vida_atual = vida_maxima

func porcentagem_vida() -> float:
	return vida_atual / vida_maxima

class VidaAlterada:
	var vida_anterior: float
	var vida_atual: float
	var vida_maxima: float
	var porcentagem_vida: float
	var cura: bool

	func _init(
		p_vida_anterior: float,
		p_vida_atual: float,
		p_vida_maxima: float,
		p_porcentagem_vida: float,
		p_cura: bool
	) -> void:
		self.vida_anterior = p_vida_anterior
		self.vida_maxima = p_vida_maxima
		self.vida_atual = p_vida_atual
		self.porcentagem_vida = p_porcentagem_vida
		self.cura = p_cura

class VidaMaximaAlterada:
	var vida_maxima_anterior: float
	var vida_maxima_atual: float
	var diferenca: float

	func _init(p_vida_maxima_anterior: float, p_vida_maxima_atual: float) -> void:
		self.vida_maxima_anterior = p_vida_maxima_anterior
		self.vida_maxima_atual = p_vida_maxima_atual
		self.diferenca = p_vida_maxima_atual - p_vida_maxima_anterior
