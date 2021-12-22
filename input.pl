check_horizontal_and_vertical(H,V):-
    (\+ (V == 0 , H == 0)),
    ((H == 2 ; H == 0 ; H == (-2)),(V == 1 ; V == (-1) ; V == 0));
    ((H == 1 ; H == 0 ; H == (-1)),(V == 2 ; V == (-2) ; V == 0)).

isValidCoord(X) :- X =< 8, X >= 0.

ln :- print('\n').

isValidNumber(X):- X>= 1, X=<5.

getPlayer1(X) :-
    print('Input the name of the first player: '),
    read(X).

getPlayer2(X) :-
    print('Input the name of the second player: '),
    read(X).
        
askforH_and_V(H,V):- print('Please input a value to add to row (horizontal): '),
                     read(H),
                     print('Please input a value to add to column (vertical): '),
                     read(V),
                     (\+check_horizontal_and_vertical(H,V)->askforH_and_V(H1,V1)).

askForInput(R, C, V, H) :-
    print('Please input a Row (horizontal): '),
    read(R),
    print('Please input a Column (vertical): '),
    read(C),
    print('Please input a value to add to row (horizontal): '),
    read(H),
    print('Please input a value to add to column (vertical): '),
    read(V),
    (\+check_horizontal_and_vertical(H,V)->askforH_and_V(H1,V1)); print('Well Done :)').

read_number(Number):-
  write('Choose an Option: '),
  read(Number),
  (isValidNumber(Number)->menu_option(Number));read_number(N1).
