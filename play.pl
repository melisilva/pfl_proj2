:-include('./input.pl').
:-include('./board.pl').
:-include('./menu.pl').
:-include('./computer.pl').


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

loop(-1, _).
loop(I, [BoardState, CP]) :-
    print(CP), nl,
    askForInput(R, C, V, H, [BoardState, CP]),
    (move([R, C, V, H], [BoardState, CP], NewGameState)
    ->(game_over(NewGameState, Winner)
      -> menu
      ; changePlayer(CP, NewCP), loop(0, [NewBoardState, NewCP]))
    ; loop(I, [BoardState, CP])).

unzipMove([R, C, V, H], R, C, V, H).

%loop_pc(GameState, Type)
loop_PC([BoardState, CP], Type) :-
    (Type == 'Human'
    -> askForInput(R, C, V, H, [BoardState, CP]), 
      (move([R, C, V, H], [BoardState, CP], NewGameState) 
      ->(game_over(NewGameState, Winner)
        -> menu
        ; loop_PC(NewGameState, 'PC'))
      ; loop_PC([BoardState, CP], 'Human'))
    ; choose_move([BoardState, CP], Move, Level),
      unzipMove(Move, R, C, V, H),
      (move([R, C, V, H], [BoardState, CP], NewGameState)
      -> (game_over(NewGameState, Winner)
         -> menu
         ; loop_PC(NewGameState, 'Human'))
      ; loop_PC([BoardState, CP], 'PC')
      )).
    

start :-
    initial_state(GameState),
    display_game(GameState),
    loop(0, GameState).

unzip_game([BoardState, CP], BoardState, CP).
start_HP_PC :-
    initial_state(GameState),
    unzip_game(GameState, BoardState, CP),
    display_game(GameState),
    loop_PC([BoardState, CP], 'Human').

start_PC_HP :-
    initial_state(GameState),
    unzip_game(GameState, BoardState, CP),
    display_game(GameState),
    loop_PC([BoardState, CP], 'PC').

/*
display_game(GameState)
move(GameState,Move,NewGameState)
game_over(GameState,Winner)
valid_moves(GameState, ListOfMoves)
value(GameState,Player,Value) optional
choose_move(GameState,Level,Move) PC move
*/

%play/0
%main predicate for game start, presents the main menu

/*recebe o tamanho do tabuleiro como argumento e devolve o estado inicial do jogo
Let's consider 3 different sizes: 9 (normal one), 6, 7
This is for eGameStatetra credit*/
initial_state(Size,GameState):- initial_state(Size, GameState).