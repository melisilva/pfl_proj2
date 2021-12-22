:-include('./input.pl').

clear :- write('\33\[2J').

menu_option_format(Option, Details):-
  format('*~t~d~t~15|~t~a~t~40+~t*~57|~n',
        [Option, Details]).

menu_header_format(Header):-
  format('~n~`*t ~p ~`*t~57|~n', [Header]).

renpaarden_logo:-
    write(' ########    #########  ####      ##  ########     ###        ###     ########    ########   #########  ####      ##\n'),
    write(' ##     ##   ##         ## ##     ##  ##     ##   ## ##      ## ##    ##     ##   ##     ##  ##         ## ##     ##\n'),
    write(' ##     ##   ##         ##  ##    ##  ##     ##  ##   ##    ##   ##   ##     ##   ##     ##  ##         ##  ##    ##\n'),
    write(' ########    #########  ##   ##   ##  ########  ##     ##  ##     ##  ########    ##     ##  #########  ##   ##   ##\n'),
    write(' ## ##       ##         ##    ##  ##  ##        #########  #########  ## ##       ##     ##  ##         ##    ##  ##\n'),
    write(' ##   ##     ##         ##     ## ##  ##        ##     ##  ##     ##  ##   ##     ##     ##  ##         ##     ## ##\n' ),
    write(' ##     ##   #########  ##      ####  ##        ##     ##  ##     ##  ##     ##   ########   #########  ##      ####\n').

menu :-
  renpaarden_logo,
  write('\n\n'),
  menu_option_format(1, 'Human vs Human'),
  menu_option_format(2, 'Human vs Computer'),
  menu_option_format(3, 'Computer vs Computer'),
  menu_option_format(4, 'Intructions'),
  menu_option_format(5, 'Exit'),
  write('\n\n'),
  read_number(Number).

menu_option(4):-
  %clear,
  menu_header_format('INSTRUCTIONS'),
  write('\n\n'),
  write('  Renpaarden is played in a 9x9 square board dimensões, by two players.\n'),
  write('  Each player starts with 18 stones (different colors - one player has black pieces, the other has white ones).\n'),
  write('  In their turn, a player must move one of their stones. They move like a chess horse,\n'),
  write('that is, they are able to move multiple squares at once: 1 square vertically and 2\n'),
  write('horizontally or 2 squares vertically and 1 horizontally, resembling the letter "L".\n'),
  write('  There is a special rule, however: if a stone jumps to a square that has the opponents stone\n'),
  write('the player can play that stone again, this cycle repeats itself until the stone hits an empty square.\n'),
  write('  The game ends when one of the players stones occupies the original positions of their opponents stones.\n\n'),
  menu.

menu_option(5):-
  write('Thank You For Playing\n\n'),
  renpaarden_logo.
