extends Estado


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Função virtual, chamada por `_unhandled_input`.
func manipular_entrada(_evento: InputEvent) -> void:
	pass


# Função virtual, chamada por `_process`.
func atualizar(_delta: float) -> void:
	pass


# Função virtual, chamada por `_physics_process`.
func atualizar_fisica(_delta: float) -> void:
	pass


# Função chamada na mudança de estado pela maquina de estado.
# `_params` é um dicionário arbitrário a ser definido pelo estado em si
func entrar(_params := {}) -> void:
	pass


# Função chamada pela máquina de estado antes da transição de estado.
# Usada para "limpar" o estado (resetar variáveis, etc).
func sair() -> void:
	pass
