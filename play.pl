:-include('./input.pl').
:-include('./board.pl').


initialBoard([
    [1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [-1,-1,-1,-1,-1,-1,-1,-1,-1],
    [-1,-1,-1,-1,-1,-1,-1,-1,-1]
]).

next_player('P1', 'P2').
next_player('P2', 'P1').

loop(-1, _).
loop(I, X, CP) :-
    print(CP),nl,
    askForInput(R, C, V, H, X, CP),
    play(R, C, V, H, X, X1, CP),
    (check_WhitePlayer_won(X, 'P1') ; check_BlackPlayer_won(X, 'P2')
    -> loop(-1, X1)
    ; changePlayer(CP, NewCP), loop(0, X1, NewCP)
    ),
    loop(I, X, CP).

start :-
    initialBoard(X),
    printBoard(X),
    loop(0, X, 'P1').

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
This is for extra credit*/
initial_state(Size,GameState):- initialBoard(Size, GameState).

