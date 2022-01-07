check_horizontal_and_vertical(H,V):-
    print('H: '), print(H), ln,
    print('V: '), print(V), ln,
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
        
askForInput(R, C, V, H) :-
    print('Please input a Row (horizontal): '),
    read(R),
    print('Please input a Column (vertical): '),
    read(C),
    repeat,
    print('Please input a value to add to row (horizontal): '),
    read(H),
    print('Please input a value to add to column (vertical): '),
    read(V),
    check_horizontal_and_vertical(H,V),
    !.

read_number(Number):-
  write('Choose an Option: '),
  read(Number),
  (isValidNumber(Number)->menu_option(Number));read_number(N1).
