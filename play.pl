/*
initial_state(Size, GameState)
display_game(GameState)
move(GameState,Move,NewGameState)
game_over(GameState,Winner)
valid_moves(GameState, ListOfMoves)
value(GameState,Player,Value) optional
choose_move(GameState,Level,Move) PC move
*/

%play/0
%main predicate for game start, presents the main menu

