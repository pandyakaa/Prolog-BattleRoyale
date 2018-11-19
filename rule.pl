/* File rule-rule kendali dasar */

/* START */

start :- g_read(started, X), X = 1, write('Game sudah dimulai'), nl, fail, !.
start :-
	g_read(started, X), X = 0, !,
	g_assign(started, 1),
	set_seed(50), randomize,
	init_everything,
	main_loop.

	/* untuk command init_xx dan main_loop ada di file main */


/* VALIDASI STARTED */

has_started:- g_read(started,0), write('Game belum dimulai!!'),nl,!, fail.
has_started:- g_read(started,1),!.

/* HELP */

help :- has_started,print_help.

	/* untuk command print_xx ada di file print */

/* QUIT */

quit :-
	has_started, nl,
	write('Terimakasih sudah memainkan game ini !!'), nl,
	halt.

/* LOOK */

/* MOVE */

atas :- has_started, gerak_atas, !.
atas :- fail.
bawah :- has_started, gerak_bawah,!.
bawah :- fail.
kanan :- has_started, gerak_kanan , !.
kanan :- fail.
kiri :- has_started, gerak_kiri ,!.
kiri :- fail.

	/* untuk command gerak_xx ada di file player */

/* PRINT STATUS */

status :-
	has_started,
	print_status.
	
	/* untuk command print_xx ada di file print */


