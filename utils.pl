insert_elem(I,L1,E,L2):-insert_elem_aux(I,L1,E,[],L3),
                        invert(L3,L2).

insert_elem_aux(I,[],E,L,L).
insert_elem_aux(0,[H|T],E,L1,L2):- insert_elem_aux(-1,T,E,[H,E|L1],L2).
insert_elem_aux(I,[H|T],E,L1,L2):- I =\= 0,
                                   I1 is I-1,
                                   insert_elem_aux(I1,T,E,[H|L1],L2).         


delete_elem(I,L1,E,L2):- delete_elem_aux(I,L,E,-1,[],R1),
                         invert(R1,R).

delete_elem_aux(I,[],E,E,L,L).
delete_elem_aux(0,[H|T],E,E1,L1,R):- delete_elem_aux(-1,T,E,H,L1,R).
delete_elem_aux(I,[H|T],E,E1,L1,R):- I=\=0,
                                     I1 is I-1,
                                     delete_elem_aux(I1,T,E,E1,[H|L1],R).

