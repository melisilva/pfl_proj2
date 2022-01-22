:- use_module(library(random)).

%Level 1 
%choose_move(-GameState, +Move, -Level)
/* Escolhe a jogada do computador */
choose_move(GameState, Move, Level) :-
    valid_moves(GameState, Moves),
    length(Moves, N),
    random(1, N, Index),
    nth1(Index, Moves, Move).

/* Desdobra R-C em elementos singulares */
unzipPos(R-C, R, C).

%valid_moves(-GameState, +Moves)
/* Obtém as jogadas possíveis a partir de GameState */
valid_moves(GameState, Moves) :-
    valid_pos(GameState, Positions),
    valid_moves_aux(GameState, Positions, Moves).

/* Jogadas V-H válidas */
valid_V_H(1, 2).
valid_V_H(-1, 2).
valid_V_H(1, -2).
valid_V_H(-1, -2).
valid_V_H(2, 1).
valid_V_H(-2, 1).
valid_V_H(2, -1).
valid_V_H(-2, -1).

%valid_move_pos(-GameState, -R, -C, ?Moves)
/* Obtém todas as jogadas válidas a partir da posição (R, C) - usada com a regra especial do jogo. */
valid_move_pos([BoardState,CP], R, C, Moves):-
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
        -> isWhite(DestinationCol)
        ; isBlack(DestinationCol))) %Needs to go to an empty thing.
    ), 
    Moves),
    length(Moves, N),
    random(1, N, Index),
    nth1(Index, Moves, Move),
    unzipMove(Move, R, C, V, H),
    move([R, C, V, H], [BoardState, CP], NewGameState,'PC').

%valid_moves_aux(-GameState, -Positions, +Moves)
/* Obtem todas as jogadas válidas para todas as posições.  */
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
        -> isWhite(DestinationCol)
        ; isBlack(DestinationCol))) %Needs to go to an empty thing.
    ), 
    IntermediateMoves),
    valid_moves_aux([BoardState,CP], Tail,MoreIntermediatePlays),
    append(IntermediateMoves,  MoreIntermediatePlays, Moves).

%doesNotGoBack(-R, -CP)
/* Verifica que a linha horizontal escolhida não é uma daquelas onde o jogador tem de colocar as suas peças.
É feito para que o computador não ande para trás e para a frente com peças que já estão numa posição final. */
doesNotGoBack(R, CP) :-
    (isPlayer1(CP)
    -> R < 7
    ; R > 1).

%valid_pos(-GameState, +Positions)
/* Obtém todas as posições possíveis de jogar. */
valid_pos([BoardState, CP], Positions) :-
    findall(R-C,
    (
        nth0(R, BoardState, Line),
        nth0(C, Line, Col),
        (isPlayer2(CP)
        -> isBlack(Col)
        ; isWhite(Col)),
        doesNotGoBack(R, CP)
    ),
    Positions).

