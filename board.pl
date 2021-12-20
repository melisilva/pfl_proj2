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
    nth0(R, X, Line),
    nth0(C, Line, Col),
    I1 is R + H,
    nth0(I1, X, Line1),
    I2 is C + V,
    nth0(I2, Line1, Col1),
    (Col1 is empty
    -> (Col is white
       -> I is C + V, delete_elem(I, Line1, E, Line2), nth0(I, Line2, white, Line1)
       ; I is C + V, delete_elem(I, Line1, E, Line2), nth0(I, Line2, black, Line1)
       )
    ; error('Não foi escolhida uma posição-alvo vazia.')
    ),
    Col1 is Col,
    Col is empty.

error(X) :- print(X).