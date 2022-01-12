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
    print('NewR '),print(NewR),nl,
    NewC is 0,
    get_player_row_col(X, CP, [NewR, NewC], Acc, R_C).

get_player_row_col(X, CP, [R, C], Acc, R_C) :-
    get_val(X, [R, C], Value), !,
    (
       /*print('Value '),print(Value),nl,*/
        Value \= 0,
        get_player(Value, CP),
        print('R '),print(R),nl,print('C '),print(C),nl,
        append(Acc, [[R, C]], NewAcc)
        ;
        NewAcc = Acc
    ),
    NewC is C + 1,
    print('NewC '),print(NewC),nl,
    get_player_row_col(X, CP, [R, NewC], NewAcc, R_C).

get_val(X, [NewR, NewC], Value) :-
    nth0(NewR, X, R),
    nth0(NewC, R, Value), 
    /*print('Value '),print(Value),nl,*/ !.

get_player(Pos, 'P1') :-
    Pos == 1.

get_player(Pos, 'P2') :-
    Pos == -1.

addMovesToList(FinalList, _, [], FinalList).
addMovesToList(List, Position, [Move | Rest], FinalList) :-
    append(Position, Move, NewMove),
    append(List, [NewMove], NewList),
    addMovesToList(NewList, Position, Rest, FinalList).

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
    valid_plays_ver_hor(X, CP, Pos, Move, V_H),
    NewMove is Move + 1,
    print('NewMove '),print(NewMove),nl,
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
        print('Move '),print(Move),nl,
        valid_ver_hor(Move, V, H),
        print('H '),print(H),nl,
        print('V '),print(V),nl,
        print('C '),print(C),nl,
        print('R '),print(R),nl, 
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