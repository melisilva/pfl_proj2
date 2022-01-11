%Level 1 
/*
    Já feito:
    -> choose_play (choose_move),
    -> valid_plays (valid_moves),
    -> get_player_row_col (get_player_stack_positions),
    -> get_pos (get_stack_position),
    -> get_player
*/

choose_play(X, CP, 1, Play) :-
    valid_plays(X, CP, Plays),
    length(Plays, N),
    random(1, N, Index),
    nth1(Index, Plays, Play),
    !.

valid_plays(X, CP, Plays) :-
    get_player_row_col(X, CP, R_C),
    valid_plays(X, CP, R_C, [], Plays).

valid_plays(_, _, [], Plays, Plays).

valid_plays(X, CP, [R_C | Rest], Acc, Plays) :-
    valid_plays_pos(X, CP, R_C, BoardPlays),
    addPlaysToList(Acc, R_C, BoardPlays, NewAcc),
    valid_plays(X, CP, Rest, NewAcc, Plays).

get_player_row_col(X, CP, R_C) :-
    get_player_row_col(X, CP, [0, 0], [], R_C).

get_player_row_col(_, _, [8, 8], R_C, R_C).

get_player_row_col(X, CP, [R, C], Acc, R_C) :-
    C > 8,
    NewR is R + 1,
    NewC is 0,
    get_player_row_col(X, CP, [NewR, NewC], Acc, R_C).

get_player_row_col(X, CP, [R, C], Acc, R_C) :-
    get_val(X, [R, C], Value), !,
    (
        Value \= 0,
        get_player(Value, CP),
        append(Acc, [[R, C]], NewAcc)
        ;
        NewAcc = Acc
    ),
    NewC is C + 1,
    get_player_row_col(X, CP, [R, NewC], NewAcc, R_C).

get_val(X, [NewR, NewC], Value) :-
    nth0(NewR, X, R),
    nth0(NewC, R, Value), !.

get_player(Pos, 'P1') :-
    Pos == 1.

get_player(Pos, 'P2') :-
    Pos == -1.

valid_plays_pos(X, CP, Pos, Plays) :-
    valid_plays_pos(X, CP, Pos, 0, [], Plays).

valid_plays_pos(_, _, _, Plays, Plays).

valid_ver_hor(0, 1, 2).
valid_ver_hor(1, -1, 2).
valid_ver_hor(2, 1, -2).
valid_ver_hor(3, -1, -2).
valid_ver_hor(4, 2, 1).
valid_ver_hor(5, -2, 1).
valid_ver_hor(6, 2, -1).
valid_ver_hor(7, -2, -1).

valid_plays_pos(X, CP, Pos, Move, Acc, Plays) :- 
    valid_ver_hor(Move, _, _),
    NewMove is Move + 1,
    valid_plays_ver_hor(X, CP, Pos, Move, V_H),
    length(V_H, N),
    (
        N > 0,
        addMovesToList(Acc, [Move], Moves, NewAcc)
        ;
        NewAcc = Acc
    ),
    valid_plays_pos(X, CP, Pos, NewMove, NewAcc, Plays).

valid_plays_ver_hor(X, CP, Pos, Move, Plays) :-
    valid_plays_ver_hor(X, CP, Pos, Move, [], Plays).

valid_plays_ver_hor(_, _, _, _, Plays, Plays).

valid_plays_ver_hor(X, CP, [R, C], Move, Acc, Plays) :-
    (
        valid_ver_hor(Move, V, H),
        isValidPos(R, C, V, H, X, CP), !,
        append(Acc, [Move], NewAcc)
        ;
        NewAcc = Acc        
    ),
    !,
    valid_plays_ver_hor(X, CP, [R, C], Move, NewAcc, Plays).

%Level 2
%choose_move(X,CP,2,Move):- %select move based on board evaluation

%isValidPos(Row, Collum, Vertical, Horizontal, Board, Player) 