move(GameState, Move, NewGameState):- selectPiece(GameState, Move, NewGameState, MoveWay, Piece),
                                      movePiece(GameState, NewGameState, Move, MoveWay, Piece).

selectPiece(GameState, Move, NewGameState, MoveWay, Piece):- getInput(GameState, SelectColumn, SelectRow, MoveWay),
                                                             validateChoices(SelectColumn, SelectRow, GameState, NewGameState, Move, MoveWay, Piece).
                                                             
