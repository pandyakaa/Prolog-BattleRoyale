/* File MAIN */

/* START THE GAME */

start :- g_read(started, X), X = 1, write('Game has already started'), nl, fail, !.
start :-
	g_read(started, X), X = 0, !,
	g_assign(started, 1),
	set_seed(50), randomize,
	init_everything,
	asserta(deadzone_timer(7)), !,
	main_loop.

/* Main loop of the program */
main_loop :-
  	print_title, print_player_nearby,
  	repeat,
  		set_seed(50), randomize,
  		write('\nDo something > '),
  		read(Input), nl,
  		%is_input(Input),
		call(Input), nl,
		exec(tick), nl, is_turn(Input),
  	(Input == quit; endGame).

/* Init everything when game started without load */
init_everything :-
    	initItems,
		init_Player,
		initDeadzone,
    	init_enemy(10).

initDeadzone :-
	asserta(deadzone_area(0)).

/* Check for command which not make a turn */

/* for save status look map, the player dont make a turn */
is_turn(load) :- !.
is_turn(save) :- !.
is_turn(status) :- !.
is_turn(look) :- !.
is_turn(help) :- !.
is_turn(map) :- !.
is_turn(listing) :- !.

/* make a turn */
is_turn(attack):-
	generate_random_move(10).
is_turn(atas) :-
	enemy_attack,
	generate_random_move(10).
is_turn(kanan) :-
	enemy_attack,
	generate_random_move(10).
is_turn(kiri) :-
	enemy_attack,
	generate_random_move(10).
is_turn(bawah) :-
	enemy_attack,
	generate_random_move(10).
is_turn(_) :-
	generate_random_move(10),
	enemy_attack.

  /* check if the game is finished */
  is_finished(Input) :-
  	Input = quit, !.
  is_finished(_) :-
  	\+ enemy(_,_,_,_), nl,
  print_win, nl, quit, !.
  is_finished(_) :-
  	player(_,_,Health,_,_,_,_), ! ,
  	Health =< 0, nl,
  print_lose, nl, quit,!.
