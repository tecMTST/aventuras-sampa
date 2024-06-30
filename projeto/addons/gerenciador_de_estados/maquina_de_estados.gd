# Classe de Maquina de Estado.
# Adaptada de https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
class_name MaquinaDeEstados
extends Node


# Sinal emitido após transição de estado.
signal transicionado(nome_estado)

# Caminho para estado inicial.
export var estado_inicial := NodePath()

# Estado ativo.
onready var estado = get_node(estado_inicial)


func _ready() -> void:
	yield(owner, "ready")
	for crianca in get_children():
		crianca.maquina_de_estado = self
	estado.entrar()


# Chamados do nódulo são delegados para o estado atual.
func _unhandled_input(evento: InputEvent) -> void:
	estado.manipular_entrada(evento)


func _process(delta: float) -> void:
	estado.atualizar(delta)


func _physics_process(delta: float) -> void:
	estado.atualizar_fisica(delta)


# Chama `sair` do estado atual, muda o estado atual, chama `entrar` do novo estado atual (usando `params`), emite `transicionado`
func transicionar(novo_estado: String, params: Dictionary = {}) -> void:
	assert(not has_node(novo_estado), "Estado não econtrado: %s." % novo_estado)

	estado.sair()
	estado = get_node(novo_estado)
	estado.entrar(params)
	emit_signal("transicionado", estado.name)
