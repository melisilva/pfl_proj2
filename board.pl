:- use_module(library(lists)).
:- consult('./utils.pl').
:- consult('./print.pl').

isEmpty(X) :- X == 0.
isBlack(X) :- X == 1.
isWhite(X) :- X == -1.

initialBoard([
    [1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1],
    [1,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [-1,-1,-1,-1,-1,-1,-1,-1,-1],
    [-1,-1,-1,-1,-1,-1,-1,-1,-1]
]).

play(R, C, H, V, X1) :-
    initialBoard(X),
    printBoard(X),
    nth0(R, X, Line),
    nth0(C, Line, Col),
    I1 is R + H,
    nth0(I1, X, Line1),
    I2 is C + V,
    nth0(I2, Line1, Col1),
    (isEmpty(Col1)  
    -> (isWhite(Col)
       -> I is C + V, replace(I, Line1, -1, Line2), replace(R, X, Line2, X1)
       ; I is C + V, replace(I, Line1, 1, Line2), replace(R, X, Line2, X1)
       )
    ; error('Posicao alvo nao esta vazia.')
    ),
    printBoard(X1).

error(X) :- print(X).