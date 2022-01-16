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

changePlayer('P1', 'P2').
changePlayer('P2', 'P1').

loop(-1, _).
loop(I, [BoardState, CP]) :-
    print(CP), nl,
    askForInput(R, C, V, H, [BoardState, CP]),
    (move([R, C, V, H], [BoardState, CP], NewGameState)
    ->(game_over(NewGameState, Winner) ; game_over(NewGameState, Winner)
      ->menu
      ; changePlayer(CP, NewCP), loop(0, [NewBoardState, NewCP]))
    ; loop(I, [BoardState, CP])).

unzipMove([R, C, V, H], R, C, V, H).

loop_PC(-1, _).
%loop_pc(I, GameState)
loop_PC(I, [BoardState, CP]) :-
    (isPlayer2(CP)
    -> choose_move(BoardState, CP, Move, Level),
       unzipMove(Move, R, C, V, H),
       (move([R, C, V, H], BoardState, NewBoardState, CP)
       ->(game_over(NewBoardState, Winner) ; game_over(NewBoardState, Winner)
         ->menu
         ; changePlayer(CP, NewCP), loop(0, [NewGameState, NewCP]))
       ; loop(I, [BoardState, CP])
        )
    ; askForInput(R, C, V, H, GameState, CP),
      (move([R, C, V, H], GameState, NewGameState, CP)
       ->(game_over(NewBoardState, Winner) ; game_over(NewBoardState, Winner)
         -> menu
         ; changePlayer(CP, NewCP), loop(0, [NewBoardState, NewCP]))
       ; loop(I, [BoardState, CP])
      )
    ).
    

start :-
    initial_state(GameState),
    display_game(GameState),
    loop(0, GameState).

start_PC :-
    initial_state(GameState),
    display_game(GameState),
    loop_PC(0, GameState).

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

