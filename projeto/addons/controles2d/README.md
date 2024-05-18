## Compoente de Controles 2D Básicos

#### Propriedades Comuns:
* ativo : Booleano (true) = Se o componente esta ativo ou não    
* controle_up : string ("up") = Valor associado ao input de 'Up'
* controle_down : string ("down") = Valor associado ao input de 'Down'
* controle_left : string ("left") = Valor associado ao input de 'Left'
* controle_right : string ("right") = Valor associado ao input de 'Right'
* controle_correr : string ("sprint") = Valor associado ao input de 'Sprint'
* velocidade_andar : Float (300.0) = Velocidade base do personagem
* velocidade_correr : Float (600.0) = Velocidade de sprint do personagem 
* aceleracao : Float =(50.0) = Aceleração do movimento
* desaceleracao : Float (50.0) = Desaceleração do movimento
* referencia_sprites : string ("sprites") = Referencia do grupo de sprites para ter a direção manipulada
* tipo_movimento : enum{move_and_slide, move_and_collide, none} (move_and_slide) = Se utiliza move_and_slide, move_and_collide ou não processa o movimento

### Controle SideScrolling 2D:

#### Propriedades:

* modo : enum{autonomo, gatilho} (autonomo) = se vai processar o movimento de modo 
    * autônomo: atravez dos inputs e da execução do movimento no parent.
    * gatilho: atravez da funções de gatilho: processar(direction : Vector2, delta: Float) -> Vector2
* controle_no_ar: booleano (true) = Se permite o controle no ar
* tratar_gravidade: booleano (true) =  Se tratará a gravidade (se usado em conjunto com o Componente de pulo, desativar esta opção)
* multiplicador_de_gravidade : float (1.0) = Multiplica a gravidade por este valor, funciona apenas caso o componente esteja tratando a gravidade.

### Controle Pulo 2D:

#### Propriedades:

* modo : enum{autonomo, gatilho} (autonomo) = se vai processar o movimento de modo:
    * autônomo: atravez dos inputs e da execução do movimento no parent. 
    * gatilho: atravez da funções de gatilho: pular() -> Vector2, finalizar_pulo() -> Vector2 e processar(delta : float) -> Vector2
* controle_pulo_variavel : Booleano (true) = Se o pulo dependo de manter ou não a ação precionada, caso sim, quando a ação for liberada o pulo e cancelado, ou no caso de estar no modo de gatilhoi, quando for chamada a função finalizar_pulo().
* controle_pulo : string ("jump") = Valor associado ao input de 'Jump'
* velocidade_pulo : Float (900.0) = Velocidade aplicada ao eixo y (para cima, inversão de sinal ja tratada internamente, usar valor positivo)
* tempo_de_buffer_de_pulo : Float (0.1) = Tempo que o pulo e reconhecido antes do personagem atingir o chão.
* tempo_de_coyote : Float (0.1) = Tempo que o pulo e reconhecido depois que o personagem saiu de uma plataforma.
* multiplicador_de_gravidade : float (1.0) = Multiplica a gravidade por este valor.
* multiplicador_de_queda : float (1.0) = Multiplica a gravidade final (depois de ser multiplicada pelo multiplicador_de_gravidade) por este valor, apenas apos o topo da parabola de pulo, acelerando assim a queda.

### Controle TopDown 2D:

#### Propriedades:

* modo_de_controle : enum{direcional, rotacional, click} (direcional) = Qual o modo de controle do movimento, pode ser: 
    * direcional: obedece os inputs direcionais. 
    * rotacinal: Estilo asteroid, roaciona e se movimento no sentido da roação.
    * click: De move para um ponto clicado na tela.
* rotacionar : enum {desativada, tudo, sprite_apenas} (tudo) = Tratamento da rotação pode ser:
    * desativada: Não rotaciona.
    * tudo: personagem rotaciona como um todo.
    * sprite_apenas: apenas as sprites referenciadas rotacionam.
* controle_click : string ("click") = Valor associado ao input de 'Click'
* velocidade_rotacao : Float (20.0) = Velociade da rotação.
* rotacao_travada_no_mouse : Booleano (false) = A rotação sempre apontará para o mouse (modo Click apenas).