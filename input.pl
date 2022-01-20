check_horizontal_and_vertical(H,V):-
    ((H==2; H== (-2)),(V==1; V== (-1)));
    ((H==1; H== (-1)),(V==2; V== (-2))).

ln :- print('\n').

isValidNumber(Number) :- Number >= 1, Number =<5.

checkR_C(R, C, [BoardState, CP]) :-
    R =< 8, R >= 0, C =< 8, C >= 0,
    nth0(R, BoardState, Line),
    nth0(C, Line, Col),
    \+ (isEmpty(Col)).

askForInput(R, C, V, H, GameState) :-
    repeat,
    (
        (
            print('Please input a Row (horizontal): '),
            read(R),
            print('Please input a Column (vertical): '),
            read(C),
            checkR_C(R, C, GameState)
        ),
        (
            print('Please input a value to add to row (horizontal): '),
            read(H),
            print('Please input a value to add to column (vertical): '),
            read(V),
            check_horizontal_and_vertical(H,V)
        ),
    isValidPos([R, C, V, H], GameState)
    ).

askForHV(R, C, V, H, [BoardState,CP]):-
   repeat,
    (
        (
            print('Please input a value to add to row (horizontal): '),
            read(H),
            print('Please input a value to add to column (vertical): '),
            read(V),
            check_horizontal_and_vertical(H,V)
        ),
    isValidPos([R, C, V, H], [BoardState,CP])
    ),
    move([R,C,V,H], [BoardState,CP], [NewBoardState,NewCP],'Human').

read_number(Number):-
  write('Choose an Option: '),
  read(Number),
  (isValidNumber(Number)->menu_option(Number)) ; read_number(N1).
