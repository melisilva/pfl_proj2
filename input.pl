isValidCoord(X) :- X =< 8, X >= 0.
check_horizontal_and_vertical(H,V):- ((H==2; H== (-2)),(V==1; V== (-1))); ((H==1; H== (-1)),(V==2; V== (-2))).
        
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






%turn(X)