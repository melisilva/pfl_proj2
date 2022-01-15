check_horizontal_and_vertical(H,V):-
    print(H),nl,print(V),nl,
    ((H==2; H== (-2)),(V==1; V== (-1)));
    ((H==1; H== (-1)),(V==2; V== (-2))).

isValidCoord(X) :- X =< 8, X >= 0.

ln :- print('\n').

isValidNumber(X):- X>= 1, X=<5.

getPlayer1(X) :-
    print('Input the name of the first player: '),
    read(X).

getPlayer2(X) :-
    print('Input the name of the second player: '),
    read(X).

checkR_C(R, C, X) :-
    R =< 8, R >= 0, C =< 8, C >= 0,
    nth0(R, X, Line),
    nth0(C, Line, Col),
    \+ (isEmpty(Col)).

askForInput(R, C, V, H, X, CP) :-
    repeat,
    (
        (
            print('Please input a Row (horizontal): '),
            read(R),
            print('Please input a Column (vertical): '),
            read(C),
            checkR_C(R, C, X)
        ),
        (
            print('Please input a value to add to row (horizontal): '),
            read(H),
            print('Please input a value to add to column (vertical): '),
            read(V),
            check_horizontal_and_vertical(H,V)
        ),
    isValidPos(R, C, V, H, X, CP)
    ).

askForHV(R,C,V,H,X,CP):-
   repeat,
   (
       (
       print('Please input a value to add to row (horizontal): '),
       read(H),
       print('help'),
       print('Please input a value to add to column (vertical): '),
       read(V),
       check_horizontal_and_vertical(H,V)
       ),
     isValidPos(R, C, V, H, X, CP)
    ),
    play(R,C,V,H,X,CP).

read_number(Number):-
  write('Choose an Option: '),
  read(Number),
  (isValidNumber(Number)->menu_option(Number));read_number(N1).
