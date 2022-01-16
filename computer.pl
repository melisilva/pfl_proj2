:- use_module(library(random)).

%Level 1 
/*
    Já feito:
    -> choose_play (choose_move),
    -> valid_plays (valid_moves),
    -> get_player_row_col (get_player_stack_positions),
    -> get_pos (get_stack_position),
    -> get_player
*/

choose_move(GameState, Move, Level) :-
    valid_moves(GameState, Moves),
    length(Moves, N),
    random(1, N, Index),
    nth1(Index, Moves, Move).

unzipPos(R-C, R, C).

valid_moves(GameState, Moves) :-
    valid_pos(GameState, Positions),
    valid_moves_aux(GameState, Positions, Moves).

valid_V_H(1, 2).
valid_V_H(-1, 2).
valid_V_H(1, -2).
valid_V_H(-1, -2).
valid_V_H(2, 1).
valid_V_H(-2, 1).
valid_V_H(2, -1).
valid_V_H(-2, -1).

valid_move_pos([BoardState,CP],R,C,Moves):-
    findall([R,C,V,H],
    (
        valid_V_H(V, H),
        H1 is (R) + (H),
        V1 is (C) + (V), 
        H1 =< 8,
        H1 >= 0,
        V1 =< 8,
        V1 >= 0,
        nth0(R, BoardState, Line),
        nth0(C, Line, Col),
        (isPlayer2(CP)
        -> isBlack(Col)
        ; isWhite(Col)),
        nth0(H1, BoardState, DestinationLine),
        nth0(V1, DestinationLine, DestinationCol),
        (isEmpty(DestinationCol) ;
        (isPlayer2(CP)
        -> isBlack(Col)
        ; isWhite(Col))) %Needs to go to an empty thing.
    ), 
    Moves),
    length(Moves, N),
    random(1, N, Index),
    nth1(Index, Moves, Move),
    unzipMove(Move, R, C, V, H),
    move([R, C, V, H], [BoardState, CP], NewGameState,'PC').


valid_moves_aux(GameState, [], Moves) :- !.
valid_moves_aux([BoardState, CP], [Head|Tail], Moves) :-
    unzipPos(Head, R, C),
    findall([R, C, V, H],
    (
        valid_V_H(V, H),
        H1 is (R) + (H),
        V1 is (C) + (V), 
        H1 =< 8,
        H1 >= 0,
        V1 =< 8,
        V1 >= 0,
        nth0(R, BoardState, Line),
        nth0(C, Line, Col),
        (isPlayer2(CP)
        -> isBlack(Col)
        ; isWhite(Col)),
        nth0(H1, BoardState, DestinationLine),
        nth0(V1, DestinationLine, DestinationCol),
        (isEmpty(DestinationCol) ;
        (isPlayer2(CP)
        -> isBlack(Col)
        ; isWhite(Col))) %Needs to go to an empty thing.
    ), 
    IntermediateMoves),
    valid_moves_aux([BoardState,CP], Tail,MoreIntermediatePlays),
    append(IntermediateMoves,  MoreIntermediatePlays, Moves).

valid_pos([BoardState, CP], Positions) :-
    findall(R-C,
    (
        nth0(R, BoardState, Line),
        nth0(C, Line, Col),
        (isPlayer2(CP)
        -> isBlack(Col)
        ; isWhite(Col))
    ),
    Positions).

%Level 2
%choose_move(GameState, CP, 2, Move):- %select move based on board evaluation

%isValidPos(Row, Collum, Vertical, Horizontal, Board, Player) 