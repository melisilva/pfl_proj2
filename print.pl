/* Predicados de impressão da representação visual do jogo */

symbol(0,S):- S='-'.
symbol(-1,S):- S='B'.
symbol(1,S):- S='W'.
symbol(-3,S):-S='M'.

letter(1, L) :- L='0'.
letter(2, L) :- L='1'.
letter(3, L) :- L='2'.
letter(4, L) :- L='3'.
letter(5, L) :- L='4'.
letter(6, L) :- L='5'.
letter(7, L) :- L='6'.
letter(8, L) :- L='7'.
letter(9, L) :- L='8'.

/* Predicado principal */
display_game([BoardState, CP]) :-
    print('CP: '), print(CP), nl,
    write('   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |\n'),
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
