isValidCoord(X) :- X =< 8, X >= 0.
        
askForInput(R, C, V, H) :-
    print('Please input a Row (horizontal): '),
    read(R),
    print('\nPlease input a Collumn (vertical): '),
    read(C),
    print('Please input a value to add to row (horizontal): '),
    read(V),
    print('\nPlease input a value to add to collumn (vertical): '),
    read(H).





turn(X)