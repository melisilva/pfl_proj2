/*
display_game(GameState)
move(GameState,Move,NewGameState)
game_over(GameState,Winner)
valid_moves(GameState, ListOfMoves)
value(GameState,Player,Value) optional
choose_move(GameState,Level,Move) PC move
*/

%play/0
%main predicate for game start, presents the main menu

/*recebe o tamanho do tabuleiro como argumento e devolve o estado inicial do jogo
Let's consider 3 different sizes: 9 (normal one), 6, 7
This is for extra credit*/
initial_state(Size,GameState):- initialBoard(Size, GameState).

