check_horizontal_and_vertical(H,V):- 
    (((H==2; H== (-2)),(V==1; V== (-1))) ; ((H==1; H== (-1)),(V==2; V== (-2)))
    -> print('Correct!')
    ; print('Naur!')
    ).


isValidCoord(X) :- X =< 8, X >= 0.

getPlayer1(X) :-
    print('Input the name of the first player: '),
    read(X).

getPlayer2(X) :-
    print('Input the name of the second player: '),
    read(X).
        
askForInput(R, C, V, H) :-
    print('Please input a Row (horizontal): '),
    read(R),
    print('\nPlease input a Collumn (vertical): '),
    read(C),
    print('Please input a value to add to row (horizontal): '),
    read(V),
    print('\nPlease input a value to add to collumn (vertical): '),
    read(H),
    check_horizontal_and_vertical(H,V).
