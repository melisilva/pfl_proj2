isValidCoord(X) :- X =< 8, X >= 0.
check_horizontal_and_vertical(H,V):- ((H==2; H== (-2)),(V==1; V== (-1))); ((H==1; H== (-1)),(V==2; V== (-2))).
        
askForInput(R, C, V, H) :-
    print('Please input a Row (horizontal): '),
    read(R),
    print('Please input a Column (vertical): '),
    read(C),
    print('Please input a value to add to row (horizontal): '),
    read(V),
    print('Please input a value to add to collumn (vertical): '),
    read(H),
    check_horizontal_and_vertical(H,V).






%turn(X)