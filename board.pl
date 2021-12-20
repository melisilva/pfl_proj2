:- use_module(library(lists)).
:- consult('./utils.pl').

initialBoard([
    [black,black,black,black,black,black,black,black,black],
    [black,black,black,black,black,black,black,black,black],
    [empty,empty,empty,empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty,empty,empty,empty],
    [white,white,white,white,white,white,white,white,white],
    [white,white,white,white,white,white,white,white,white]
]).

direction(ver).
direction(hor).

play(R, C, H, V) :-
    initialBoard(X),
    nth0(R, X, line),
    nth0(C, line, col),
    I1 is R + H,
    nth0(I1, X, line1),
    I2 is C + V,
    nth0(I2, line1, col1),
    (col1 is empty
    -> (col is white
       -> I is C + V, delete_elem(I, line1, E, line2), nth0(I, line2, white, line1)
       ; I is C + V, delete_elem(I, line1, E, line2), nth0(I, line2, black, line1)
       )
    ; error('Não foi escolhida uma posição-alvo vazia.')
    ),
    col1 is col,
    col is empty.

error(X) :- print(X).