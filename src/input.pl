
%check_horizontal_and_vertical(H, V)
/* Verifica se a jogada formada por H e V segue o movimento em L */
check_horizontal_and_vertical(H,V):-
    ((H==2; H== (-2)),(V==1; V== (-1)));
    ((H==1; H== (-1)),(V==2; V== (-2))).

/* Imprime um newline */
ln :- print('\n').

/* Verifica os números fornecidos no input para o Menu */
isValidNumber(Number) :- Number >= 1, Number =< 6.

%checkR_C(-R, -C, -GameState)
/* Verifica se a posição dada por (R, C) no tabuleiro é válida */
checkR_C(R, C, [BoardState, CP]) :-
    R =< 8, R >= 0, C =< 8, C >= 0,
    nth0(R, BoardState, Line),
    nth0(C, Line, Col),
    \+ (isEmpty(Col)).

%askForInput(?R, ?C, ?V, ?H, -GameState)
/* Obtém input para R, C, V, H e verifica-o. */
askForInput(R, C, V, H, GameState) :-
    repeat,
    (
        (
            print('Please input a Row (horizontal): '),
            read(R),
            print('Please input a Column (vertical): '),
            read(C),
            checkR_C(R, C, GameState)
        ),
        (
            print('Please input a value to add to row (horizontal): '),
            read(H),
            print('Please input a value to add to column (vertical): '),
            read(V),
            check_horizontal_and_vertical(H,V)
        ),
    isValidPos([R, C, V, H], GameState)
    ).

%askForHV(-R, -C, ?V, ?H, -GameState)
/* Predicado para obter input para a regra especial do jogo. */
askForHV(R, C, V, H, [BoardState, CP]):-
   repeat,
    (
        print('Please input a value to add to row (horizontal): '),
        read(H),
        print('Please input a value to add to column (vertical): '),
        read(V),
        check_horizontal_and_vertical(H,V),
        isValidPos([R, C, V, H], [BoardState,CP])
    ).

%read_number(?Number)
/* Lê a opção dada pelo utilizador no Menu. */
read_number(Number):-
  write('Choose an Option: '),
  read(Number),
  (isValidNumber(Number)->menu_option(Number)) ; read_number(N1).
