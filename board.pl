:- use_module(library(lists)).
:- consult('./utils.pl').
:- consult('./print.pl').

isEmpty(Pos) :- Pos == 0.
isBlack(Pos) :- Pos == (-1); Pos == (-3).
isWhite(Pos) :- Pos == 1; Pos == (-3).
isOnlyWhite(Pos) :- Pos == 1.
isOnlyBlack(Pos) :- Pos == -1.
isMiGameStateed(Pos) :- Pos == -3.
isEqual(Pos1, Pos2) :- Pos1 == Pos2.
isPlayer1(CP) :- CP == 'P1'.
isPlayer2(CP) :- CP == 'P2'.
changePlayer('P1', 'P2').
changePlayer('P2', 'P1').


%isValidPos(Row, Collum, Vertical, Horizontal, Board, Player)
%Checks if R and C give a valid position and if R + V and C + H do as well.
%If not, its not possible to play.
isValidPos('').
isValidPos([R, C, V, H], [BoardState, CP]) :-
    H1 is R + (H),
    V1 is C + (V),
    nth0(R, BoardState, Line),
    nth0(C, Line, Col),
    (isPlayer1(CP)
    -> (isWhite(Col)
        -> (H1 =< 8, H1 >= 0, V1 =< 8, V1 >= 0
            -> isValidPos('')
            ; error('The computed position is not within the board.'), nl, fail
           )
        ; isWhite(Col), !
       )
    ; (CP \= 'P1', isBlack(Col)
      -> (H1 =< 8, H1 >= 0, V1 =< 8, V1 >= 0
         -> isValidPos('')
         ; error('The computed position is not within the board.'), nl, fail
         )
      ; isBlack(Col), !
      )
    ),
    !.


move([R, C, V, H], [BoardState, CP], [NewBoardState, NewCP]) :-
    nth0(R, BoardState, Line), %Get the corresponding line.
    nth0(C, Line, Col), %Get the corresponding collumn.
    I1 is R + H,
    nth0(I1, BoardState, Line1),
    I2 is C + V,
    nth0(I2, Line1, Col1),
    (isEmpty(Col1)  %If Col1 is not empty, then we have 2 options.
    -> (isOnlyWhite(Col)
       -> I is C + V, 
          replace(I, Line1, 1, Line2), %First, we replace the thing with the new value (-1 or 1).
          replace(I1, BoardState, Line2, BoardState2), %And replace the board with the new line.
          replace(C, Line, 0, Line3), %Then we replace the old position with 0, as it is now empty.
          replace(R, BoardState2, Line3, NewBoardState), %And replace the board with the new line.
          changePlayer(CP, NewCP),
          display_game([NewBoardState, NewCP])
       ; (isOnlyBlack(Col)
         ->I is C + V,
          replace(I, Line1, -1, Line2),
          replace(I1, BoardState, Line2, BoardState2),
          replace(C, Line, 0, Line3),
          replace(R, BoardState2, Line3, NewBoardState),
          changePlayer(CP, NewCP),
          display_game([NewBoardState, NewCP])
       ; (isPlayer1(CP)
          ->I is C + V,
          replace(I, Line1, 1, Line2),
          replace(I1, BoardState, Line2, BoardState2),
          replace(C, Line, -1, Line3),
          replace(R, BoardState2, Line3, NewBoardState),
          changePlayer(CP, NewCP),
          display_game([NewBoardState, NewCP])
      ;   I is C + V,
          replace(I, Line1, -1, Line2),
          replace(I1, BoardState, Line2, BoardState2),
          replace(C, Line, 1, Line3),
          replace(R, BoardState2, Line3, NewBoardState),
          changePlayer(CP, NewCP),
          display_game([NewBoardState, NewCP])
       )))
    ; (isEqual(Col1, Col) %If he landed on a place where there is already a piece of the same color...
      -> error('You cannot jump to a place you yourself are ocupying!'), nl, fail %...then it is not a valid play to make.
      %One can only jump should they land on a place with a piece of the opposite color.
      ; I is C + V,
        replace(I, Line1, -3, Line2),
        replace(I1, BoardState, Line2, BoardState2),
        replace(C, Line, 0, Line3),
        replace(R, BoardState2, Line3, NewBoardState),
        changePlayer(CP, NewCP),
        display_game([NewBoardState, CP]),
        askForHV(I1, I2, V1, H1, [NewBoardState, NewCP])
      )
    ).
    

error(GameState) :- print(GameState).

/*
"O jogo termina quando um dos jogadores consegue que todas as suas pedras atinjam a posição inicial das pedras do seu adversário."

Player white wins if the first two rows (indeGameStatees 0 and 1---> A and B) only have white pieces
Player black wins if the last two rows (indeGameStatees 7 and 8--->H and I) only have black pices

We can check this using the function list_member:
-For the first two rows we check lets say they are in the variable Row, we check: list_member(0, Row), if we get a yes, it means 
theres empty spaces there, so the game didnt end, no one is a winner (also idea to check if game ended); we should also check 
list_member(-1,Row), if we get yes, Player black hasnt won. If we get no to both we are golden
- Same logic for the last two rows but we check list_member(1,Row).
*/

game_over([BoardState, CP], Winner):- 
   (isPlayer1(CP)
   -> check_WhitePlayer_won(BoardState, CP, Winner)
   ; check_BlackPlayer_won(BoardState, CP, Winner)
   ).

check_WhitePlayer_won(X, Y, Winner) :- 
   nth0(7, X, Row), 
   \+list_member(0, Row),
   \+list_member(-1, Row),
   nth0(8, X, Row1), 
   \+list_member(0, Row1), 
   \+list_member(-1, Row1),
   Winner is Y,
   congratulate_winner(Y).

check_BlackPlayer_won(X, Y, Winner):-
   nth0(0, X, Row), 
   \+list_member(0, Row), 
   \+list_member(1, Row), 
   nth0(1, X, Row1), 
   \+list_member(0, Row1), 
   \+list_member(1, Row1),
   Winner is Y,
   congratulate_winner(Y).

congratulate_winner(Y) :-
   print('Congrats on winning the game, player '),
   print(Y),
   nl.
