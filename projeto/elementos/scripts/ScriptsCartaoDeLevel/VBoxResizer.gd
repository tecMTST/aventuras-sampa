tool
extends VBoxContainer

export var ajuste_manual: int = 0 # setar o numero de nodes se quiser fazer o ajuste manual
export var tamanho_total: int = 330 # setar o tamanho das nodes de noticias

onready var quantidade_de_criancas = get_child_count()

func _atualizador_de_container():
	if ajuste_manual == 0: # se o ajuste manual for igual a 0 ele ira pegar a quantidade de nodes no container e usar como quantidade
		self.rect_min_size.y = tamanho_total * quantidade_de_criancas
		print(self.rect_min_size.y)
		print(quantidade_de_criancas)
	
	else: # se tiver qualquer numero no ajuste manual ele irá pegar o numero e multiplicar pelo tamanho total
		self.rect_min_size.y = tamanho_total * ajuste_manual
		print(self.rect_min_size.y)
		print(quantidade_de_criancas)

func _ready():
	_atualizador_de_container()
