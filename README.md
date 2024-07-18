# Modelo NT Godot 3.6

## Estrutura de Arquivos

A pasta `exportados` deverá conter as builds do jogo.

O projeto de Godot em si deve ficar dentro da pasta `projeto`.

A pasta `projeto/recursos/addons` deve conter os componentes reutilizaveis.
Caso um componente seja útil e robusto o suficiente, ele poderá ser reintegrado ao nosso modelo no GitHub.

```
.
├── exportados
├── projeto
│   ├── elementos
│   │   ├── imagem
│   │   ├── musica
│   │   ├── som
│   │   └── texto
│   └── recursos
│       ├── addons
│       └── cenas
├── README.md
```

### Componentes Reutilizaveis

Componentes na pasta de addons devem ser transformados em _plugins_. Veja mais sobre: [Tutorial de Plugin](TutorialPlugin.md).

## Código

### Nomes

Todo o código deve ser escrito em português.
Nomes de pasta, cenas e scripts devem ser sempre em `snake_case`.
Exemplos: `jogador/componente_controle.gd`, `menu_pausa.tscn`.

Variáveis privadas devem ser iniciadas com um `_`:

```gdscript
func _calcular_velocidade():
  pass
```

### Documentação

Funções públicas _sempre_ devem ser documentadas com type hints:

```gdscript
func gerar_nova_posicao(posicao_alvo: Vector2, posicao_passada: Vector2) -> Vector2:
  pass
```

Funções com parâmetros e retorno não claros devem ter comentários explicando em mais detalhe.
Isso pode acontecer principalmente devido às limitações de type-hint da Godot `3.x`.

```gdscript
### Recebe Array de Vector2
func posicao_media(posicoes: Array) -> Vector2:
  pass
```

#### Ordem de Declarações

Declarações devem seguir a ordem: _definição do arquivo_ `->` _declarações públicas_ `->` _declarações privadas_ `->` _funções_.

Exemplo:

```gdscript
class_name ClasseTeste
extends Node


export var variavel_um: float
export var variavel_dois: PackedScene

signal sinal_um
signal sinal_dois(parametro)


var privada_um = 3
onready var privada_dois = $Componente
var privada_tres = Vector2.ONE


func _ready():
  pass


func funcao_publica():
  pass
```

### Práticas de Design

Funções devem ser, sempre que possível, puras (i.e. sem efeitos colaterais).
A responsabilidade de aplicar as mudanças propostas pela função deve ser de quem a chamou.
Por exemplo, uma função que calcula a nova quantidade de uma entidade.

Procurar fazer assim:

```gdscript
func calcular_vida(entidade: Node, danificador: Node) -> float:
  var modificador = 1
  if danificador.tipo in entidade.fraquezas:
    modificador = danificador.modificador
  return entidade.vida + entidade.defesa - danificador.dano * modificador
```

Ao invés de:

```gdscript
func calcular_vida(entidade: Node, danificador: Node):
  var modificador = 1
  if danificador.tipo in entidade.fraquezas:
    modificador = danificador.modificador
  entidade.vida += entidade.defesa - danificador.dano * modificador
```

 
