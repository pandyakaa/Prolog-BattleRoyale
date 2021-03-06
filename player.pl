:-dynamic(player/7).
:-dynamic(enemy/4).


/*Initial Player Stats*/
initHealth(80).
initArmor(0).
initWeapon(akm).
initInventory([bandage,vest,uzi]).
initAmmo([10,10]).


randomCoordinate(X, Y):-
    random(2, 18, A), random(2, 18, B),
    X is A, Y is B.


    init_Player:-
        initHealth(Health),
        initArmor(Armor),
        initWeapon(Weapon),
        initInventory(Inventory),
        randomCoordinate(X, Y),
        initAmmo(Ammo),
        asserta(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)), !.

%Health
    increase_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
        NewHealth is Amount+Health,
        NewHealth > 100,
        retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
        asserta(player(X,Y,100,Armor,Weapon,Inventory,Ammo)).
    increase_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
        NewHealth is Amount+Health,
        retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
        asserta(player(X,Y,NewHealth,Armor,Weapon,Inventory,Ammo)).

    decrease_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
        NewHealth is Health - Amount,
        Armor = 0,
        NewHealth < 0,
        retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
        asserta(player(X,Y,0,Armor,Weapon,Inventory,Ammo)).

    decrease_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
        NewHealth is Health - Amount,
        Armor = 0,
        retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
        asserta(player(X,Y,NewHealth,Armor,Weapon,Inventory,Ammo)).

    decrease_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
        NewHealth is Health + Armor - Amount,
        decrease_Armor(Armor),
        player(_,_,_,NewArmor,_,_,_),
        retract(player(X,Y,Health,NewArmor,Weapon,Inventory,Ammo)),
        asserta(player(X,Y,NewHealth,NewArmor,Weapon,Inventory,Ammo)).


    health_Status(Health):- player(_,_,Health,_,_,_,_).
%replace

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).


%Ammo
    increase_Ammo(Amount,ar):-
      player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
      nth0(0,Ammo,Ar),
      NewAr is Ar+Amount,
      replace(Ammo,0,NewAr,NewAmmo),
      retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
      asserta(player(X,Y,Health,Armor,Weapon,Inventory,NewAmmo)).

    decrease_Ammo(Amount,ar):-
      player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
      nth0(0,Ammo,Ar),
      NewAr is Ar-Amount,
      replace(Ammo,0,NewAr,NewAmmo),
      retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
      asserta(player(X,Y,Health,Armor,Weapon,Inventory,NewAmmo)).

    increase_Ammo(Amount,smg):-
      player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
      nth0(1,Ammo,Smg),
      NewSmg is Smg+Amount,
      replace(Ammo,1,NewSmg,NewAmmo),
      retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
      asserta(player(X,Y,Health,Armor,Weapon,Inventory,NewAmmo)).

    decrease_Ammo(Amount,smg):-
      player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
      nth0(1,Ammo,Smg),
      NewSmg is Smg-Amount,
      replace(Ammo,1,NewSmg,NewAmmo),
      retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
      asserta(player(X,Y,Health,Armor,Weapon,Inventory,NewAmmo)).



%Armor
    set_Armor(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
        retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
        asserta(player(X,Y,Health,Amount,Weapon,Inventory,Ammo)).

    decrease_Armor(Amount):-
            player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
            NewArmor is Armor - Amount,
            NewArmor < 0,
            retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
            asserta(player(X,Y,Health,0,Weapon,Inventory,Ammo)).

    decrease_Armor(Amount):-
            player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
            NewArmor is Armor - Amount,
            retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
            asserta(player(X,Y,Health,NewArmor,Weapon,Inventory,Ammo)).

%attack-check

%Weapon

set_weapon(Weapon):-
    retract(player(X,Y,Health,Armor,CurrentWeapon,Inventory,Ammo)),
    asserta(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)).

%Position
get_position(X,Y):-
    player(X,Y,_,_,_,_,_).

%item addition and deletion

add_item(Item):-
    retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
    append([Item],Inventory,NewInventory),
    asserta(player(X,Y,Health,Armor,Weapon,NewInventory,Ammo)).

del_item(Item):-
  retract(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
  delete_one(Item,Inventory,NewInventory),
  asserta(player(X,Y,Health,Armor,Weapon,NewInventory,Ammo)).

delete_one(_, [], []).
delete_one(Term, [Term|Tail], Tail) :- !.
delete_one(Term, [Head|Tail], [Head|Result]) :-
    delete_one(Term, Tail, Result).

/*move*/
step_up:-
    player(X,CurrentY,Health,Armor,Weapon,Inventory,Ammo),
    CurrentY > 0,
    Y is CurrentY-1,
    retract(player(X,CurrentY,Health,Armor,Weapon,Inventory,Ammo)),
    asserta(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
    deadzone_timer(T),
      Tn is T-1,
      retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
      (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
       write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl).

step_down:-
    player(X,CurrentY,Health,Armor,Weapon,Inventory,Ammo),
    CurrentY < 20,
    Y is CurrentY+1,
    retract(player(X,CurrentY,Health,Armor,Weapon,Inventory,Ammo)),
    asserta(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
    deadzone_timer(T),
      Tn is T-1,
      retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
      (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
       write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl).

step_left:-
    player(CurrentX,Y,Health,Armor,Weapon,Inventory,Ammo),
    CurrentX > 0,
    X is CurrentX-1,
    retract(player(CurrentX,Y,Health,Armor,Weapon,Inventory,Ammo)),
    asserta(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
    deadzone_timer(T),
      Tn is T-1,
      retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
      (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
       write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl).

step_right:-
    player(CurrentX,Y,Health,Armor,Weapon,Inventory,Ammo),
    CurrentX < 20,
    X is CurrentX+1,
    retract(player(CurrentX,Y,Health,Armor,Weapon,Inventory,Ammo)),
    asserta(player(X,Y,Health,Armor,Weapon,Inventory,Ammo)),
    deadzone_timer(T),
      Tn is T-1,
      retract(deadzone_timer(T)), asserta(deadzone_timer(Tn)),
      (Tn == 0, write('DEADZONE IS SHRINKING! BE CAREFUL.'), nl;
       write(Tn), write(' more tick to deadzone shrink. watch your move.'),nl).

/*enemy*/

init_enemy(0) :- !.
init_enemy(N) :- generate_enemy(N), M is N-1, init_enemy(M).

initHealthE(20).

generate_enemy(Id):-
  initHealthE(Health),
  randomCoordinate(X,Y),
  asserta(enemy(Id, X,Y,Health)).

%health
decrease_HealthE(Id, Amount):-
    enemy(Id,X,Y,Health),
    NewHealth is Health - Amount,
    NewHealth > 0,
    print_fail_kill,
    retract(enemy(Id,X,Y,Health)),
    asserta(enemy(Id,X,Y,NewHealth)),!.

decrease_HealthE(Id, Amount):-
    enemy(Id,X,Y,Health),
    NewHealth is Health - Amount,
    NewHealth =< 0,
    drop_item(X,Y),
    print_enemy_kill,
  	print_drop_item,
    retract(enemy(Id,X,Y,Health)).

/* drop item */
drop_item(X,Y):-
	random(1,5,Rand),
	Rand is 3,
	drop_medicine(X,Y),!.

drop_item(X,Y):-
	random(1,5,Rand),
	Rand is 4,
	drop_weapon(X,Y),!.

drop_medicine(X,Y):-
	random(1, 4, N),
	medicineHeal(N,A,_),
	asserta(location(X,Y,A)).

drop_weapon(X,Y):-
	random(1,5,N),
	weaponName(N,A),
	asserta(location(X,Y,A)).

/*enemy exist*/

check_enemy_exist :-
	player(X,Y,_,_,_,_,_),
	is_enemy_exist(X, Y),
	write('There\'s enemy in your sigh'), nl, !.

is_enemy_exist(X, Y) :-
	enemy(_, A, B, Health),
	A =:= X, B =:= Y, !.

is_enemy_all_dead :-
	\+ enemy(_,_,_,_).


/*nearby enemy*/
check_enemy_nearby :-
	player(X,Y,_,_,_,_,_),
	enemy_nearby(X,Y).

enemy_nearby(X, Y) :-
	A is X, B is Y,
	enemy(_, A, B, _), !.
enemy_nearby(X, Y) :-
	A is X-1, B is Y-1,
	enemy(_, A, B, _), !.
enemy_nearby(X, Y) :-
	A is X, B is Y-1,
	enemy(_, A, B, _), !.
enemy_nearby(X, Y) :-
	A is X+1, B is Y-1,
	enemy(_, A, B, _), !.
enemy_nearby(X, Y) :-
	A is X-1, B is Y,
	enemy(_, A, B, _), !.
enemy_nearby(X, Y) :-
	A is X+1, B is Y,
	enemy(_, A, B, _), !.
enemy_nearby(X, Y) :-
	A is X-1, B is Y+1,
	enemy(_, A, B, _), !.
enemy_nearby(X, Y) :-
	A is X, B is Y+1,
	enemy(_, A, B, _), !.
enemy_nearby(X, Y) :-
	A is X+1, B is Y+1,
	enemy(_, A, B, _), !.

/*enemy_moves*/
generate_random_move(0) :- !.
generate_random_move(N) :- random_move(N), M is N-1, generate_random_move(M).


random_move(Id) :-
	random(1, 6, N),
	step(Id, N), !.
random_move(_) :- !.

  step(Id, 1) :-
  	stepup(Id), !.
  step(Id, 2) :-
  	stepdown(Id), !.
  step(Id, 3) :-
  	stepleft(Id), !.
  step(Id, 4) :-
  	stepright(Id), !.
  step(Id, 5) :- !.

  stepup(Id):-
  	enemy(Id, X, CurrentY, Health),
  	CurrentY > 0,
  	NewY is CurrentY-1,
  	retract(enemy(Id, X, CurrentY, Health)),
  	asserta(enemy(Id, X, NewY, Health)),
	check_deadzone_enemy(X,NewY).

  stepdown(Id):-
  	enemy(Id, X, CurrentY, Health),
  	CurrentY < 20,
  	NewY is CurrentY+1,
  	retract(enemy(Id, X, CurrentY, Health)),
  	asserta(enemy(Id, X, NewY, Health)),
	check_deadzone_enemy(X,NewY).

  stepleft(Id):-
  	enemy(Id, CurrentX, Y, Health),
  	CurrentX > 0,
  	NewX is CurrentX-1,
  	retract(enemy(Id, CurrentX, Y, Health)),
  	asserta(enemy(Id, NewX, Y, Health)),
	check_deadzone_enemy(NewX,Y).

  stepright(Id):-
  	enemy(Id, CurrentX, Y, Health),
  	CurrentX < 20,
  	NewX is CurrentX+1,
  	retract(enemy(Id, CurrentX, Y, Health)),
  	asserta(enemy(Id, NewX, Y, Health)),
	check_deadzone_enemy(NewX,Y).

check_deadzone_enemy(X,Y):-
    enemy(Id, X,Y,_),
    deadzone_area(A),
    (X@=<A; Y@=<A; Aright is 19-A ,X@>=Aright; Aright is 19-A ,Y@>=Aright), !,
    write('Enemy '), write(Id), write(' is dead by entering deadzone.'), nl,
    retract(enemy(Id,X,Y,Health)) , !.

check_deadzone_enemy(X,Y) :-
    enemy(Id, X, Y, Health),
    asserta(enemy(Id,X,Y, Health)).
