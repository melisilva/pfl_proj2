:- use_module(library(lists)).

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
    nth0(R + H, X, line1),
    nth0(C + V, X, col1),
    col1 is col,
    col is empty.
