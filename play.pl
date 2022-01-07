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

changePlayer(P, P1, P1, P2).
changePlayer(P, P2, P1, P2).
changePlayer(P, NP, P1, P2) :-
    (P = P1
    -> changePlayer(P, P2, P1, P2)
    ; changePlayer(P, P1, P1, P2)
    ).

loop(-1, _).
loop(I, X, CP, P1, P2) :-
    askForInput(R, C, V, H),
    print('R: '), print(R), ln,
    print('C: '), print(C), ln,
    print('V: '), print(V), ln,
    print('H: '), print(H), ln,
    print('X: '), print(X), ln,
    play(R, C, V, H, X, X1,'P1'),
    (check_WhitePlayer_won(P1) ; check_BlackPlayer_Won(P2)
    -> loop(-1, X1, P1, P2)
    ; changePlayer(P, NP, P1, P2), loop(0, X1, NP, P1, P2)
    ).

start :-
    initialBoard(X),
    getPlayer1(P1),
    getPlayer2(P2),
    loop(0, X, P1, P1, P2).

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

