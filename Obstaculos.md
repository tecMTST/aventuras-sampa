## JSON de Modulos

[Local do JSON](./projeto/elementos/modulos.json)

- gerar estrutura no inicio do level

```TS
interface modulo{
  tempo: int, // em segundos
  grupo: int,
  obstaculos: int[][],
  chace: float
}
```

## Índice

### Grupos

- 0: sem grupo

### Obstaculos

- 0: sem obstaculo
- 1: obstaculo aleatorio de chao
- 2: obstaculo x
