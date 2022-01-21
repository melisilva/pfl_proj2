# Projeto de PFL em PROLOG

## Identificação do Trabalho e Grupo

O jogo recriado neste projeto foi o *Renpaarden*.

O grupo ***Renpaarden_1*** é composto pelos seguintes elementos:

- Mateus Ferreira da Silva (up201906232) 
- Melissa Moreira da Silva (up201905076)

Ambos os elementos contribuíram 50%, totalizando 100%.

## Instalação e Execução

Para executar o jogo, apenas é preciso consultar o ficheiro ***menu.pl***. Para executar o jogo, deve-se invocar o predicado ***play***.

## Descrição do Jogo

*Renpaarden*, *cavalos de corrida* em alemão, é jogado num tabuleiro quadrado de dimensões 9x9, por dois jogadores. Cada jogador começa com 18 pedras (de cores diferentes - um jogador pretas, outro brancas), nas seguintes posições:

![board](imagens/renpaarden_board.png)

Na sua vez, um jogador deve mover uma das suas pedras. Estas movem-se como um cavalo de xadrez, isto é, são capazes de se deslocar múltiplos quadrados de cada vez: 1 quadrado verticalmente e 2 na horizontal ou 2 quadrados verticalmente e 1 na horizontal, fazendo então lembrar a letra "L".

Existe uma regra especial, contudo: caso uma pedra salte para um quadrado ocupado por uma pedra do adversário, o jogador pode jogar com esta de novo, o que se repete até que a pedra atinja um quadrado desocupado.

O jogo termina quando um dos jogadores consegue que todas as suas pedras atinjam a posição inicial das pedras do seu adversário.



## Lógica do Jogo

### Representação Interna do Jogo

A representação interna do jogo é uma lista chamada *GameState*. Esta inclui um primeiro elemento *BoardState* (uma lista de listas de números que representam as peças e posições vazias - criámos um código numérico para isto) e um segundo elemento *CP* que contém a designação do jogador corrente.

Em baixo, temos um possível estado inicial de um jogo, visto por um jogador e no código (- é vazio, correspondente a 0; W é uma peça branca, correspondente a 1; B é uma peça preta, correspondente a -1).

![image-20220121184507229](image-20220121184507229.png)

Um estado final (ganharam as brancas).

![image-20220121184755374](image-20220121184755374.png)

E um estado intermédio, com uma posição com *M* (duas peças de cores diferentes), correspondente a -3.

![image-20220121185056293](image-20220121185056293.png)

### Visualização do Estado do Jogo

O jogo possui um *Menu* que funciona através do *Input* de números, servindo para direcionar o jogador ao modo que preferir jogar. Este está definido em ***menu.pl***.

![Imagem do Menu](unknown.png)

Qualquer modo do jogo é representado da mesma forma, utilizando uma estrutura parecida a uma tabela e com índices de coordenadas para ajudar a fornecer jogadas. Imagens desta representação estão na subsecção acima. A representação é *impressa* sempre que *displayGame* é chamado - este predicado e seus auxiliares estão em ***print.pl***.

### Execução de Jogadas

A lógica do jogo é simples em termos teóricos: *Renpaarden* joga-se com dois jogadores, alternando a vez entre estes. Isto é conseguido com um ciclo de jogo simples, que se pode ver nos nossos predicados de prefixo *loop*. Por simplicidade, iremos focar-nos no *loop* para o jogo entre dois humanos (o primeiro que fizemos), ***loop/2***.

```perl
loop(-1, _).
loop(I, [BoardState, CP]) :-
    askForInput(R, C, V, H, [BoardState, CP]),
    (move([R, C, V, H], [BoardState, CP], NewGameState, 'Human')
    ->(game_over(NewGameState, Winner)
      -> menu
      ; loop(0, NewGameState))
    ; loop(I, [BoardState, CP])).
```

A sequência de jogo passa por pedir ao jogador *input* correspondente a uma jogada. Isto é feito em ***askForInput/5*** (definido em ***input.pl***), onde são validados os valores fornecidos: ***R*** e ***C*** definem coordenadas do tipo *(y, x)*, entre 0 e 8. Já ***V*** e ***H*** apenas podem seguir movimentos em L, como o Cavalo do Xadrez. O predicado abaixo certifica-se disso.

```perl
check_horizontal_and_vertical(H,V):-
    ((H==2; H== (-2)),(V==1; V== (-1)));
    ((H==1; H== (-1)),(V==2; V== (-2))).
```

O predicado mais importante desta secção deverá ser ***isValidPos/2***, visto que esta verifica que a jogada constituída por ***R***, ***C***, ***V*** e ***H*** é válida: (R + H, C + V) tem de resultar numa posição interior ao tabuleiro, além de verificar que ***R*** e ***C*** selecionam uma peça correta (um jogador só pode jogar peças da sua cor).

```perl
isValidPos('').
isValidPos([R, C, V, H], [BoardState, CP]) :-
    H1 is R + (H),
    V1 is C + (V),
    nth0(R, BoardState, Line),
    nth0(C, Line, Col),
    (isPlayer1(CP)
    -> (isWhite(Col)
        -> (H1 =< 8, H1 >= 0, V1 =< 8, V1 >= 0
            ; error('The computed position is not within the board.'), nl, fail
           )
        ; isWhite(Col), !
       )
    ; (CP \= 'P1', isBlack(Col)
      -> (H1 =< 8, H1 >= 0, V1 =< 8, V1 >= 0
         -> isValidPos('')
         ; error('The computed position is not within the board.'), nl, fail
         )
      ; isBlack(Col), !
      )
    ).
```

Quando o predicado anterior passa afirmativamente, ***move/4*** é o predicado onde tudo o resto acontece: este executa a jogada, o que requer muitas substituições sucessivas nas listas de *BoardState*. Isto é feito com ***replace/4*** (um predicado elaborado por nós para maior facilidade, definido em ***utils.pl***) e com o predicado do módulo *lists* ***nth0/3*** para aceder ao elemento correto.

***move/4*** lida com muitos casos:

- Um espaço vazio (0) que passa a ser ocupado por uma peça branca (1);
- Igual ao anterior, mas com uma peça preta (-1);
- Uma peça branca ou preta vai para uma posição ocupada por uma peça de cor contrária (-3);
- Uma posição duplamente ocupada (-3) passa a ser ocupada por uma só peça com um salto do jogador que a fez ficar duplamente cheia.

Além disto, ***move/4*** impede um jogador de ocupar duplamente uma posição com duas peças da mesma cor e invoca o predicado de mudança de jogador, ***changePlayer/2***.

### Final do Jogo

O final do jogo é testado com o predicado ***game_over/2***. O teste passa por verificar as 2 primeiras e 2 últimas linhas do tabuleiro: para o jogador 1, se as duas últimas estiverem preenchidas pelas suas peças brancas (1), então este ganhou; para o jogador 2, vice-versa, com as suas peças pretas (-1).

```perl
game_over([BoardState, CP], Winner):- 
   (isPlayer2(CP)
   -> check_WhitePlayer_won(BoardState, CP, Winner)
   ; check_BlackPlayer_won(BoardState, CP, Winner)
   ).
```



## **Bibliografia**

http://www.di.fc.ul.pt/~jpn/gv/renpaarden.htm

https://sites.google.com/site/boardandpieces/list-of-games/renpaarden

https://boardgamegeek.com/boardgame/70925/renpaarden

