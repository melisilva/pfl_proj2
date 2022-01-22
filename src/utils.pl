/* Inverte uma lista */
invert(List1,List2):- reverse(List1,List2,[]).

reverse([],List2,List2).
reverse([H|T],List2,Acc) :- reverse(T,List2,[H|Acc]).

/* Insere elemento em lista */
insert_elem(I,L1,E,L2):-insert_elem_aux(I,L1,E,[],L3),
                        invert(L3,L2).

insert_elem_aux(I,[],E,L,L).
insert_elem_aux(0,[H|T],E,L1,L2):- insert_elem_aux(-1,T,E,[H,E|L1],L2).
insert_elem_aux(I,[H|T],E,L1,L2):- I =\= 0,
                                   I1 is I-1,
                                   insert_elem_aux(I1,T,E,[H|L1],L2).         

/* Substitui elemento numa lista */
replace(I, L, E, K) :-
  nth0(I, L, _, R),
  nth0(I, K, E, R).

/* Verifica se elemento pertence a lista */
list_member(E,[E|_]).
list_member(E,[H|T]):- list_member(E,T).
