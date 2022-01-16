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

choose_move(GameState, CP, Play, Level) :-
    valid_moves(GameState, CP, Moves),
    length(Moves, N),
    print('Plays: '), print(Moves), nl,
    print('Length Plays: '), print(N), nl,
    random(1, N, Index),
    nth1(Index, Moves, Play).

unzipPos(R-C, R, C).

valid_moves(GameState, CP, Plays) :-
    valid_pos(GameState, CP, Positions),
    valid_moves_aux(GameState, Positions, CP, Plays).

valid_V_H(1, 2).
valid_V_H(-1, 2).
valid_V_H(1, -2).
valid_V_H(-1, -2).
valid_V_H(2, 1).
valid_V_H(-2, 1).
valid_V_H(2, -1).
valid_V_H(-2, -1).

valid_moves_aux(GameState, [], CP, Plays) :- !.
valid_moves_aux(GameState, [Head|Tail], CP, Plays) :-
    unzipPos(Head, R, C),
    findall([R, C, V, H],
    (
        valid_V_H(V, H),
        H < 0, %Só pode andar para cima.
        H1 is R + (H),
        V1 is C + (V),
        H1 =< 8,
        H1 >= 0,
        V1 =< 8,
        V1 >= 0,
        nth0(R, GameState, Line),
        nth0(C, Line, Col), 
        (isPlayer2(CP)
        -> isBlack(Col)
        ; isWhite(Col)), %Se passar isto, então é porque escolheu uma peça da cor correta.
        nth0(H1, GameState, DestinationLine),
        nth0(V1, DestinationLine, DestinationCol),
        (isPlayer2(CP)
        -> (isEmpty(DestinationCol) ; \+(isBlack(DestinationCol)))
        ; (isEmpty(DestinationCol) ; \+(isWhite(DestinationCol))))
    ), 
    IntermediatePlays),
    valid_plays_aux(GameState, Tail, MoreIntermediatePlays),
    append(IntermediatePlays, MoreIntermediatePlays, Plays).

valid_pos(GameState, CP, Positions) :-
    findall(R-C,
    (
        nth0(R, GameState, Line),
        nth0(C, Line, Col),
        (isPlayer2(CP)
        -> isBlack(Col)
        ; isWhite(Col))
    ),
    Positions).

%Level 2
%choose_move(GameState, CP, 2, Move):- %select move based on board evaluation

%isValidPos(Row, Collum, Vertical, Horizontal, Board, Player) 