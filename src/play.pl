:-include('./input.pl').
:-include('./board.pl').
:-include('./menu.pl').
:-include('./computer.pl').


%initial_state(-GameState)
/* Inicia a representação interna do jogo */
initial_state([[
    [1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [-1,-1,-1,-1,-1,-1,-1,-1,-1],
    [-1,-1,-1,-1,-1,-1,-1,-1,-1]
], 'P1']).

%loop(-I, _)
/* Predicado para terminar o predicado loop/3 */
loop(-1, _).

%loop(-I, -GameState)
/* Ciclo do jogo humano vs. humano. */
loop(I, [BoardState, CP]) :-
    askForInput(R, C, V, H, [BoardState, CP]),
    (move([R, C, V, H], [BoardState, CP], NewGameState,'Human')
    ->(game_over(NewGameState, Winner)
      -> congratulate(Winner), play
      ; loop(0, NewGameState))
    ; loop(I, [BoardState, CP])).

%congratulate(-Y)
/* Imprime mensagem de vitória do jogador em Y. */
congratulate(Y) :-
   print('Congrats on winning the game, player '),
   print(Y),
   nl.

%unzipMove(-Move, +R, +C, +V, +H)
/* Desdobra Move nos elementos singulares R, C, V e H. */
unzipMove([R, C, V, H], R, C, V, H).


%loop_pc(-GameState, -Type)
/* Ciclo dos jogos entre humano vs. computador ou computador vs. humano. */
loop_PC([BoardState, CP], Type) :-
    (Type == 'Human'
    -> askForInput(R, C, V, H, [BoardState, CP]), 
      (move([R, C, V, H], [BoardState, CP], NewGameState,'Human') 
      ->(game_over(NewGameState, Winner)
        -> congratulate(Winner), play
        ; loop_PC(NewGameState, 'PC'))
      ; loop_PC([BoardState, CP], 'Human'))
    ; choose_move([BoardState, CP], Move, Level),
      unzipMove(Move, R, C, V, H),
      (move([R, C, V, H], [BoardState, CP], NewGameState,'PC')
      -> (game_over(NewGameState, Winner)
         -> play
         ; loop_PC(NewGameState, 'Human'))
      ; loop_PC([BoardState, CP], 'PC')
      )).

%loop_only_PC(-GameState, -Type)
/* Ciclo de jogo entre dois computadores. */
loop_only_PC([BoardState, CP], Type) :-
   choose_move([BoardState, CP], Move, Level),
      unzipMove(Move, R, C, V, H),
      (move([R, C, V, H], [BoardState, CP], NewGameState,'PC')
      -> (game_over(NewGameState, Winner)
         -> print('Thank God! They did not explode!'), nl, nl, play
         ; loop_only_PC(NewGameState, 'PC'))
      ; loop_only_PC([BoardState, CP], 'PC')
      ).

%menu_option(-X)
/* Direciona a execução para o modo do jogo correto. */
menu_option(1):-
    initial_state(GameState),
    display_game(GameState),
    loop(0, GameState).

menu_option(2):-
    initial_state(GameState),
    unzip_game(GameState, BoardState, CP),
    display_game(GameState),
    loop_PC([BoardState, CP], 'Human').

menu_option(3):-
    initial_state(GameState),
    unzip_game(GameState, BoardState, CP),
    display_game(GameState),
    loop_PC([BoardState, CP], 'PC').

menu_option(4):-
    initial_state(GameState),
    unzip_game(GameState, BoardState, CP),
    display_game(GameState),
    loop_only_PC([BoardState, CP], 'PC').

%unzip_game(-GameState, +BoardState, +CP)
/* Desdobra GameState nos elementos singulares BoardState e CP. */
unzip_game([BoardState, CP], BoardState, CP).