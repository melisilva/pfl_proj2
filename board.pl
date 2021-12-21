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
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [-1,-1,-1,-1,-1,-1,-1,-1,-1],
    [-1,-1,-1,-1,-1,-1,-1,-1,-1]
]).

validPos('').
isValidPos(R, C, V, H, X) :-
    H1 is C + H,
    V1 is R + V,
    nth0(R, X, Line),
    nth0(C, Line, Col),
    (R =< 8, R >= 0, C =< 8, C >= 0, \+(isEmpty(Col))
    -> (H1 =< 8, H1 >= 0, V1 =< 8, V1 >= 0
        -> validPos('')
        ; error('The computed position is not within the board.')
       )
    ; error("You either gave an empty position or a position that's not within the board!")
    ).

play(R, C, V, H, X1) :-
    initialBoard(X),
    (isValidPos(R, C, V, H, X)
    -> printBoard(X),
       nth0(R, X, Line),
       nth0(C, Line, Col),
       I1 is R + V,
       nth0(I1, X, Line1),
       I2 is C + H,
       nth0(I2, Line1, Col1),
       (isEmpty(Col1)  
        -> (isWhite(Col)
            -> I is C + H, 
                replace(I, Line1, -1, Line2),
                replace(I1, X, Line2, X2),
                replace(C, Line, 0, Line3),
                replace(R, X2, Line3, X1),
                printBoard(X1)
            ;  I is C + H,
               replace(I, Line1, 1, Line2),
               replace(I1, X, Line2, X2),
               replace(C, Line, 0, Line3),
               replace(R, X2, Line3, X1),
               printBoard(X1)
            )
        ; (isEqual(Col1, Col)
            -> error('Not a valid play!')
            ; error('Play again.')
            )
        )
    ; error('Not a valid play!')
    ).
    

error(X) :- print(X).

/*
"O jogo termina quando um dos jogadores consegue que todas as suas pedras atinjam a posição inicial das pedras do seu adversário."

Player white wins if the first two rows (indexes 0 and 1---> A and B) only have white pieces
Player black wins if the last two rows (indexes 7 and 8--->H and I) only have black pices

We can check this using the function list_member:
-For the first two rows we check let's say they are in the variable Row, we check: list_member('empty', Row), if we get a yes, it means 
there's empty spaces there, so the game didn't end, no one is a winner (also idea to check if game ended); we should also check 
list_member('white',Row), if we get yes, Player black hasn't won. If we get no to both we are golden
- Same logic for the last two rows but we check list_member('black',Row).*/
