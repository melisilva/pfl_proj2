:- use_module(library(lists)).
:- consult('./utils.pl').
:- consult('./print.pl').


/* Predicados de validação de posições no tabuleiro */
isEmpty(Pos) :- Pos == 0.
isBlack(Pos) :- Pos == (-1); Pos == (-3).
isWhite(Pos) :- Pos == 1; Pos == (-3).
isOnlyWhite(Pos) :- Pos == 1.
isOnlyBlack(Pos) :- Pos == -1.
isMPos(Pos) :- Pos == -3.
isEqual(Pos1, Pos2) :- Pos1 == Pos2.

/* Predicados de validação do jogador corrente */
isPlayer1(CP) :- CP == 'P1'.
isPlayer2(CP) :- CP == 'P2'.

%changePlayer(+CP, +NewCP)
/* Troca o jogador corrente. */
changePlayer('P1', 'P2').
changePlayer('P2', 'P1').


%isValidPos(+R, +C, +V, +H, -GameState)
/* Verifica se R e C dão uma posição válida e se R + H e C + V também. */
isValidPos('').
isValidPos([R, C, V, H], [BoardState, CP]) :-
    H1 is R + (H),
    V1 is C + (V),
    nth0(R, BoardState, Line),
    nth0(C, Line, Col),
    (isPlayer1(CP)
    -> (isWhite(Col)
        -> (H1 =< 8, H1 >= 0, V1 =< 8, V1 >= 0
            ; error('The computed position is not within the board.'), nl
           )
        ; isWhite(Col), !
       )
    ; (CP \= 'P1', isBlack(Col)
      -> (H1 =< 8, H1 >= 0, V1 =< 8, V1 >= 0
         -> isValidPos('')
         ; error('The computed position is not within the board.'), nl
         )
      ; isBlack(Col), !
      )
    ).

%move(-Move, -GameState, -NewGameState, -Type)
/* Executa jogada, atualizando o estado interno do jogo */
move([R, C, V, H], [BoardState, CP], [NewBoardState, NewCP], Type) :-
    nth0(R, BoardState, Line), %Get the corresponding line.
    nth0(C, Line, Col), %Get the corresponding collumn.
    I1 is R + (H),
    nth0(I1, BoardState, Line1),
    I2 is C + (V),
    nth0(I2, Line1, Col1),
    (isEmpty(Col1)  %If Col1 is not empty, then we have 2 options.
    -> (isOnlyWhite(Col)
       -> replace(I2, Line1, 1, Line2), %First, we replace the thing with the new value (-1 or 1).
          replace(I1, BoardState, Line2, BoardState2), %And replace the board with the new line.
          replace(C, Line, 0, Line3), %Then we replace the old position with 0, as it is now empty.
          replace(R, BoardState2, Line3, NewBoardState), %And replace the board with the new line.
          changePlayer(CP, NewCP),
          display_game([NewBoardState, NewCP])
       ; (isOnlyBlack(Col)
         -> replace(I2, Line1, -1, Line2),
          replace(I1, BoardState, Line2, BoardState2),
          replace(C, Line, 0, Line3),
          replace(R, BoardState2, Line3, NewBoardState),
          changePlayer(CP, NewCP),
          display_game([NewBoardState, NewCP])
       ; (isPlayer1(CP)
          ->replace(I2, Line1, 1, Line2),
          replace(I1, BoardState, Line2, BoardState2),
          replace(C, Line, -1, Line3),
          replace(R, BoardState2, Line3, NewBoardState),
          changePlayer(CP, NewCP),
          display_game([NewBoardState, NewCP])
      ;   replace(I2, Line1, -1, Line2),
          replace(I1, BoardState, Line2, BoardState2),
          replace(C, Line, 1, Line3),
          replace(R, BoardState2, Line3, NewBoardState),
          changePlayer(CP, NewCP),
          display_game([NewBoardState, NewCP])
       )))
    ; (isEqual(Col1, Col) %If he landed on a place where there is already a piece of the same color...
      -> error('You cannot jump to a place you yourself are ocupying!'), nl, fail %...then it is not a valid play to make.
      %One can only jump should they land on a place with a piece of the opposite color.
      ; replace(I2, Line1, -3, Line2),
        replace(I1, BoardState, Line2, BoardState2),
        (isMPos(Col),
          (isPlayer1(CP)
          ->replace(C, Line, -1, Line3)
          ;  replace(C, Line, 1, Line3)
          ); replace(C, Line, 0, Line3)
        ),
        replace(R, BoardState2, Line3, BoardState3),
        display_game([BoardState3, CP]),
         (Type == 'Human'
          -> askForHV(I1, I2, V1, H1, [BoardState3, CP]), move([I1, I2, V1, H1], [BoardState3, CP], [NewBoardState, NewCP], Type)
         ; valid_move_pos([NewBoardState, NewCP], I1, I2, Moves)
         )
      )
    ).
    

/* Predicado para impressão de mensagens de erro. */
error(GameState) :- print(GameState).


%game_over(+GameState, -Winner)
/* Consoante o estado de GameState, declara um vencedor Winner se este já existir. */
game_over(-1, 'P1').
game_over(-1, 'P2').
game_over([BoardState, CP], Winner):- 
   (isPlayer2(CP)
   -> check_WhitePlayer_won(BoardState, CP, Winner)
   ; check_BlackPlayer_won(BoardState, CP, Winner)
   ).

/* Verifica se o jogador 1 ganhou */
check_WhitePlayer_won(-1, -1, Winner):-print('Congrats on winning the game, '), print(Winner), nl, nl.
check_WhitePlayer_won(X, Y, Winner) :- 
   nth0(7, X, Row), 
   \+list_member(0, Row),
   \+list_member(-1, Row),
   \+list_member(-3,Row),
   nth0(8, X, Row1), 
   \+list_member(0, Row1), 
   \+list_member(-1, Row1),
   \+list_member(-3, Row1),
   check_WhitePlayer_won(-1, -1, 'P1').

/* Verifica se o jogador 2 ganhou */
check_BlackPlayer_won(-1, -1, Winner):-print('Congrats on winning the game, '), print(Winner), nl, nl.
check_BlackPlayer_won(X, Y, Winner):-
   nth0(0, X, Row), 
   \+list_member(0, Row), 
   \+list_member(1, Row),
   \+list_member(-3,Row),
   nth0(1, X, Row1), 
   \+list_member(0, Row1), 
   \+list_member(1, Row1),
   \+list_member(-3, Row1),
   check_BlackPlayer_won(-1, -1, 'P2').