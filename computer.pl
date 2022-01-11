%Level 1 
choose_move(X,CP,1,Move):- %check valid moves-->use fail method,maybe ,
                          %length(moves,n),
                          %selects one move at random from the list-->random(1,n,index),
                          %nth1(index,moves,Move), !.

%Level 2
choose_move(X,CP,2,Move):- %select move based on board evaluation

