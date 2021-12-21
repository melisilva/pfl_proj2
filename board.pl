:- use_module(library(lists)).
:- consult('./utils.pl').
:- consult('./print.pl').

isEmpty(X) :- X == 0.
isBlack(X) :- X == 1.
isWhite(X) :- X == -1.
isEqual(X, Y) :- X == Y.

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

validPos('').
isValidPos(R, C, V, H) :-
    H1 is C + H,
    V1 is R + V,
    (R =< 8, R >= 0, C =< 8, C >= 0
    -> (H1 =< 8, H1 >= 0, V1 =< 8, V1 >= 0
        -> validPos('')
        ; error('Jogada irrealizavel.')
       )
    ; error('Nao foi dada uma posicao correta.')
    ).


play(R, C, V, H, X1) :-
    isValidPos(R, C, V, H),
    initialBoard(X),
    printBoard(X),
    nth0(R, X, Line),
    nth0(C, Line, Col),
    I1 is R + V,
    nth0(I1, X, Line1),
    I2 is C + H,
    nth0(I2, Line1, Col1),
    (isEmpty(Col1)  
    -> (isWhite(Col)
       -> I is C + V, replace(I, Line1, -1, Line2), replace(R, X, Line2, X2), replace(C, Line, 0, Line3), replace(R, X2, Line3, X1)
       ; I is C + V, replace(I, Line1, 1, Line2), replace(R, X, Line2, X2),  replace(C, Line, 0, Line3), replace(R, X2, Line3, X1)
       )
    ; (isEqual(Col1, Col)
      -> error('Not a valid play!')
      ; error('Play again.')
      )
    ),
    printBoard(X1).

error(X) :- print(X).
