/*
Okay so it's a text based game, player needs to provide a row and a column,
both attributes between 0 and 8 (or 1 to 9). Also player needs to 
say if they want to start to move horizontally or vertically.

Move: 1 vertical + 2 horizontal or 2 vertical + 1 horizontal
Imagine that the player says he wants to move the piece in (1,2), thinking that it's 0 to 8
If it's 1 vertical + 2 horizontal, we need to move to the next list and change inside list index
2 values-->(2,4)

In the penultimate column we can do 2 vertical + 1 horizontal, if we do the other move, we need 
to move the horizontal way towards the left (same with the last column) 

Players can only pick spaces that have either the value "black" or "white"


To check if either player won we need to see if the first two lists are filled with white, if so white player won or
if the last two lists are filled with black, if so black player won*/

symbol(0,S):- S='-'.
symbol(-1,S):- S='B'.
symbol(1,S):- S='W'.
symbol(-3,S):-S='M'.

letter(1, L) :- L='A'.
letter(2, L) :- L='B'.
letter(3, L) :- L='C'.
letter(4, L) :- L='D'.
letter(5, L) :- L='E'.
letter(6, L) :- L='F'.
letter(7, L) :- L='G'.
letter(8, L) :- L='H'.
letter(9, L) :- L='I'.

display_game([BoardState, CP]) :-
    print('CP: '), print(CP), nl,
    write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |\n'),
    write('---|---|---|---|---|---|---|---|---|---|\n'),
    printMatrix(BoardState, 1).

printMatrix([], 10).

printMatrix([Head|Tail], N) :-
    letter(N, L),
    write(' '),
    write(L),
    N1 is N + 1,
    write(' | '),
    printLine(Head),
    write('\n---|---|---|---|---|---|---|---|---|---|\n'),
    printMatrix(Tail, N1).

printLine([]).

printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    write(' | '),
    printLine(Tail).
