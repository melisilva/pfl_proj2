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

choose_play(X, CP, Play, Level) :-
    valid_plays(X, CP, Plays),
    print('plays'), nl, print(Plays).

unzipPos(R-C, R, C).

valid_plays(X, CP, Plays) :-
    valid_pos(X, Positions),
    valid_plays_aux(X, Positions, Plays).

valid_V_H(1, 2).
valid_V_H(-1, 2).
valid_V_H(1, -2).
valid_V_H(-1, -2).
valid_V_H(2, 1).
valid_V_H(-2, 1).
valid_V_H(2, -1).
valid_V_H(-2, -1).

valid_plays_aux(X, [], Plays) :- !.
valid_plays_aux(X, [Head|Tail], Plays) :-
    unzipPos(Head, R, C),
    findall([R, C, V, H],
    (
        valid_V_H(V, H),
        V < 0,
        H1 is R + H,
        V1 is C + V,
        nth0(R, X, Line),
        nth0(C, Line, Col),
        isBlack(Col),
        H1 =< 8,
        H1 >= 0,
        V1 =< 8,
        print('V1'), nl, print(V1), nl,
        V1 >= 0
    ), 
    IntermediatePlays),
    valid_plays_aux(X, Tail, MoreIntermediatePlays),
    append(IntermediatePlays, MoreIntermediatePlays, Plays).

valid_pos(X, Positions) :-
    findall(R-C,
    (
        nth0(R, X, Line),
        nth0(C, Line, Col),
        isBlack(Col)
    ),
    Positions).

%Level 2
%choose_move(X,CP,2,Move):- %select move based on board evaluation

%isValidPos(Row, Collum, Vertical, Horizontal, Board, Player) 