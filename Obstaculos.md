# Módulos

Os módulos são as estruturas que compõem o nível do jogo, representando as faixas de colisão e o posicionamento dos obstáculos e itens no cenário.

Índice:

- [Estrutura de Objetos](#estrutura-de-objetos)
  - [Tipos de Obstaculos](#tipos-de-obstaculos)
  - [Velocidade](#velocidade)
  - [Montagem do Módulo](#montagem-do-módulo)
    - [Restrições](#restrições)
    - [Exemplo de Módulo](#exemplo-de-módulo)
  - [Localização dos assets](#localização-dos-assets)
- [JSON de Modulos](#json-de-modulos)
  - [Exemplo de JSON](#exemplo-de-json)

## Estrutura de Objetos

A estrutura principal do arquivo de configuração dos módulos é a seguinte:

```TS
type Numero = `${int}` | int;

type Modulos = {
  tipos_de_obstaculos: { [key: Numero]: String },
  velocidade: { [key: Numero]: float },
  modulos: Modulo[]
}
```

Sendo que cada módulo respeita a seguinte estrutura:

```TS
interface Modulo{
  tempo: int, // em segundos
  grupo: int,
  obstaculos: int[][], // respeitar a quantidade de faixas
  chance: float // entre 0 e 1
}
```

Cada módulo tem o tempo de jogo como principal fator para que ele seja incluído no nível, seguido do grupo e o valor de chance para que seja calculada a probabilidade de ser incluído.

Para os módulos com grupo definido, a aplicação dos módulos fica restrito ao valor da chance, e uma vez aplicado, o grupo não será mais usado.
Somente o grupo `0` tem a capacidade de ser incluído a qualquer momento.

### Tipos de Obstaculos

- 0: sem obstaculo
- 1: obstaculo de chao
- 2: obstaculo aereo
- 3: obstaculo de chao grande
- 4: obstaculo aereo grande
- 5: ataque terrestre
- 6: ataque aereo
- 7: rampa
- 8: itens
  - 80: itens colecionáveis
  - 81: power-up - vida
  - 82: power-up - invencibilidade

Para cada tipo serão assumidas algumas características de cada obstáculo.

- Obstaculos terrestres e aéreos possuem posicionamento definidos pelo componente Controlador de Obstáculos
- Obstaculos que ocupem mais de uma faixa de colisão (terrestres e aéreos) devem ser quebrados em objetos do tamanho das faixas de preferência em números sequenciais.
- Cada novo tipo de obstáculo, deve ser avaliádo se cabe ao comportamento associado aos tipos existêntes ou se novos tipos e implementações precisarão serem criados
- Para os itens, temos um subtipo para associar ao efeito do item

### Velocidade

O controle de velocidade é realizado com base no tempo de jogo em segundos, definindo o multiplicador de velocidade.

Desta forma o multiplicador de velocidade global será aplicado ao cenário, todos os obstáculos e itens em tela.

Exemplo:

| tempo (s) | velocidade |
| --------- | ---------- |
| 0         | 1.0        |
| 30        | 1.2        |
| 90        | 1.5        |
| 120       | 2.0        |
| 240       | 3.0        |

### Montagem do Módulo

Ao registrar um módulo, a sequência de linhas e colunas representam a posição do obstáculo nas faixas de colisão e cada número faz referência ao id do obstáculo.
O primeiro algarismo indica o grupo e os seguintes a identificação do obstáculo.

#### Restrições

- Os obstáculos simples (1 faixa) tanto terrestres quanto aéreos podem ser descritos pelo seu id ou tipo
- Os obstáculos que ocupam mais de uma faixa de colisão (terrestres e aéreos) só podem ser descritos pelos ids que compoem o objeto
- Power-ups devem ser descritos somente pelo seu id devido a natureza do efeito do item

#### Exemplo de Módulo

Supondo que temos os seguintes obstáculos:

| id    | tipo | nome            |
| ----- | ---- | --------------- |
| 10    | 1    | saco de lixo    |
| 11    | 1    | tronco          |
| 20    | 2    | pombo           |
| 30-31 | 3    | onibus          |
| 71    | 7    | outdoor         |
| 80    | 8-0  | item coletavel  |
| 81    | 8-1  | vida            |
| 82    | 8-2  | invencibilidade |

Podemos registrar o módulo com os seguintes valores:

| linha | f1  | f2  | f3  | descricão                         |
| ----- | --- | --- | --- | --------------------------------- |
| l5    | 20  | 1   | 0   | pombo, terrestre aleatório        |
| l4    | 0   | 0   | 10  | saco de lixo                      |
| l3    | 81  | 80  | 82  | vida, coletavel e invencibilidade |
| l2    | 2   | 30  | 31  | aereo aleatório e onibus          |
| l1    | 0   | 71  | 0   | outdoor caído                     |

### Localização dos assets

Os nomes dos arquivos de assets dos obstáculos e itens devem respeitar uma estrutura de pastas de acordo com o tipo de obstáculo ou item.
Em que os arquivos ficarão localizados dentro da pasta `projeto/elementos/imagem/enchente/obstaculos/{tipo}/{id}-{nome}` para os obstáculos e na pasta `projeto/elementos/imagem/enchente/itens/{id}-{nome}` para os itens.

## JSON de Modulos

Estamos utilizando o JSON como formato para armazenar a configuração dos níveis, localizado em [projeto/elementos/modulos.json](./projeto/elementos/modulos.json).

### Exemplo de JSON

```json
{
  "tipo_de_obstaculos": {
    "1": "terrestre",
    "2": "aereo",
    "3": "terrestre-grande",
    "4": "aereo-grande",
    "5": "ataque-terrestre",
    "6": "ataque-aereo",
    "7": "rampa",
    "8": "item"
  },
  "tipo_de_itens": {
    "0": "coletavel",
    "1": "vida",
    "2": "invencibilidade"
  },
  "velocidade": {"30": 1.0, "90": 1.2, "120": 1.5},
  "modulos": [
    "tempo": 10,
      "chance": 0.3,
      "grupo": 0,
      "obstaculos": [
        [80, 0, 10],
        [2, 0, 0],
        [20, 0, 11],
        [0, 0, 20],
        [0, 0, 0]
      ]
  ]
}
```
