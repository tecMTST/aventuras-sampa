extends Node

func map(value, low1, high1, low2, high2):
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)

func salvar_globais():
	Salvamento.salvar("globais", "volumeSom", SingletonOpcoesGlobais.volumeSom)
	Salvamento.salvar("globais", "volumeSFX", SingletonOpcoesGlobais.volumeSFX)
	Salvamento.salvar("globais", "ativarBotoes", SingletonOpcoesGlobais.ativarBotoes)
	Salvamento.salvar("globais", "dificuldadeAtual", SingletonOpcoesGlobais.dificuldadeAtual)
	
func carregar_globais():
	SingletonOpcoesGlobais.volumeSom = Salvamento.carregar("globais", "volumeSom")
	SingletonOpcoesGlobais.volumeSFX = Salvamento.carregar("globais", "volumeSFX")
	SingletonOpcoesGlobais.ativarBotoes = Salvamento.carregar("globais", "ativarBotoes")
	SingletonOpcoesGlobais.dificuldadeAtual = Salvamento.carregar("globais", "dificuldadeAtual")
