/* File rule-rule kendali dasar */

/* PLAYER ATTACK  */

attack :-
	player(X,Y,_,_,Weapon,_,[_,_]),
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl),
	weaponDamage(Weapon,Damage),
	enemy(_,X,Y,_),
	atk_enemy(X,Y,Damage),!.

attack :-
	fail_attack,fail,
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl).

atk_enemy(X,Y,Damage) :-
	enemy(Id,X,Y,Health),
	Health>0,
	print_inflict_damage(Damage),
	decrease_Health(5),
	print_decrease_health(5),
	decrease_HealthE(Id,Damage),fail.

atk_enemy(_,_,_) :- !.

/* ENEMY ATTACK */
enemy_attack :-
				player(X,Y,_,_,_,_,_),
				enemy_atk(X,Y).

enemy_atk(X,Y) :-
				enemy(_,X,Y,_),
				decrease_Health(5),
				print_decrease_health(5) , fail.

enemy_atk(_,_) :- !.

/* IF GAME HAS STARTED */
has_started :-
				g_read(started,0) ,
				write('Game has not startedd yet!'),nl,!,fail.
has_started :-
				g_read(started,1),!.

/* HELP */
help :-
				has_started,print_commands.

/* QUIT */

quit :-
				has_started, nl,
				write('Terimakasih sudah memainkan game ini !!'), nl,
				halt.

/* LOOK */
look :-
				player(X,Y,_,_,_,_,_),!,
				print_player_loc(X,Y),
				print_items_loc(X,Y),
				/* Kalkulasi map */
				A is X, B is Y,
				NW_X is X-1, NW_Y is Y-1,
				N_X is X, N_Y is Y-1,
				NE_X is X+1, NE_Y is Y-1,
				W_X is X-1, W_Y is Y,
				C_X is X, C_Y is Y,
				E_X is X+1, E_Y is Y,
				SW_X is X-1, SW_Y is Y+1,
				S_X is X, S_Y is Y+1,
				SE_X is X+1, SE_Y is Y+1,nl,
				/* Print sekitar */
				print_north(N_X,N_Y), print_south(S_X,S_Y),
				print_east(E_X,E_Y), print_west(W_X,W_Y), nl,
				printMapLook(NW_X,NW_Y),!,
				printMapLook(N_X,N_Y),!,
				printMapLook(NE_X,NE_Y),!,nl,
				printMapLook(W_X,W_Y),!,
				printMapLook(A,B), !,
				printMapLook(E_X,E_Y),!, nl,
				printMapLook(SW_X,SW_Y),!,
				printMapLook(S_X,S_Y),!,
				printMapLook(SE_X,SE_Y),!,nl.

/* DROP ITEM */
drop(Object) :-
	player(X,Y,_,_,_,_,_) , !,
	player(_,_,_,_,_,Inventory,_) , !,
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl),
	member(Object,Inventory),
	del_item(Object),
	asserta(location(X,Y,Object)),
	format('You dropped ~w!',[Object]),nl,!.

drop(Object) :-
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl),
	format('Kamu tidak punya ~w!',[Object]),nl.

/* MOVE */

w :- has_started, step_up, print_atas, !.
w :- fail.
s :- has_started, step_down, print_bawah , !.
s :- fail.
d :- has_started, step_right , print_kanan ,!.
d :- fail.
a :- has_started, step_left , print_kiri , !.
a :- fail.

	/* untuk command step_xx ada di file player */

/* PRINT STATUS */

status :-
	has_started,
	print_status.

	/* untuk command print_xx ada di file print */


/* TAKE OBJECT */
take(Object) :-
	has_started, take_item(Object),nl,
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl),
	format('You have picked ~w !' , [Object]),nl,!.

take_item(Object) :-
		has_started,
		player(X,Y,_,_,_,_,_),
		location(X,Y,Object),
		add_item(Object),
		retract(location(X,Y,Object)),!.

take(_) :-
	has_started, nl ,
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl),
	write('Item is not exist'),nl,fail.



/* USE OBJECT */
use(Object) :-
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl),
	player(_,_,_,_,Weapon,Inventory,_),
	member(Object,Inventory),
	weaponName(_, Object),
	del_item(Object),
	set_weapon(Object),
	add_item(Weapon),nl,
	format('You switched your weapon to ~w !', [Object]), nl, !.

use(Object) :-
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl),
	player(_,_,_,_,_,Inventory,_),
	member(Object, Inventory),
	del_item(Object),
	effect(Object), nl, !.

use(_) :-
	deadzone_timer(T),
    Tn is T-1,
    retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
    (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
     write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl),
	nl, write('Tidak ada item!!'), nl.

/* OBJECT EFFECT */
effect(Object) :-
			itemType(Type,Object),
			give_effect(Type,Object).

give_effect(medicine,Object) :-
			medicineHeal(_,Object,Rate),
			increase_Health(Rate).
			print_increase_health(Rate).

give_effect(armor,Object) :-
		armor_rate(_,Object,Rate),
		set_Armor(Rate),
		print_armor_rate(Object,Rate).

/* SAVE */

save :-
			nl, write('Write the name of your file?'), nl,
			write('> '), read(File),
			atom_concat(File, '.txt', Filetxt),
			open(Filetxt, write, Stream),
			save_all_fact(Stream),
			close(Stream), 	write('Your file was saved !'), nl.

save_all_fact(Stream) :-
				save_location(Stream).
			save_all_fact(Stream) :-
				save_player(Stream).
			save_all_fact(Stream) :-
				save_enemies(Stream).
			save_all_fact(_) :- !.

save_location(Stream) :-
				location(X,Y,Item),
				write(Stream, location(X,Y,Item)), write(Stream, '.'), nl(Stream),
				fail.

save_enemies(Stream) :-
			 	enemy(Id, X, CurrentY, Health),
				write(Stream, enemy(EnemyID, X, Y, Health, Atk)), write(Stream, '.'), nl(Stream),
				fail.

save_player(Stream) :-
			  player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
				write(Stream,player(X,Y,Health,Armor,Weapon,Inventory,Ammo)), write(Stream, '.'), nl(Stream),
				fail.

	/* LOAD STATE */

load :-
				nl, write('Input file load!') , nl,
				write('>') , read(File),
				atom_concat(File,'.txt',Filetxt),
				load_all_fact(Filetxt).

load_all_fact(Filetxt) :-
				retractall(enemy(_,_,_,_)),
				retractall(player(_,_,_,_,_,_,_)),
				retractall(location(_,_,_)),
				open(Filetxt, read, Stream),
				repeat,
						read(Stream, In),
						asserta(In),
				at_end_of_stream(Stream),
				close(Stream),
				nl, write('Your File is loaded!'), nl, !.

load_all_fact(_):-
			  nl, write('Your input is wrong!'), nl, fail.
