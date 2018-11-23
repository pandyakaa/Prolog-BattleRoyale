/*map*/

:- dynamic(deadzone_area/1).
:- dynamic(deadzone_timer/1).
:- dynamic(playerPos/2).

area(X, Y, Region) :- X>= 1, X=<4, Y>=1, Y=<5, Region = quarry, !.
area(X, Y, Region) :- X>= 5, X=<9, Y>=1, Y=<5, Region = military_base, !.
area(X, Y, Region) :- X>= 10, X=<15, Y>=1, Y=<7, Region = mylta, !.
area(X, Y, Region) :- X>= 1, X=<5, Y>=6, Y=<11, Region = georgopol, !.
area(X, Y, Region) :- X>= 6, X=<9, Y>=6, Y=<10, Region = pochinki, !.
area(X, Y, Region) :- X>= 10, X=<15, Y>=8, Y=<12, Region = yasnaya, !.
area(X, Y, Region) :- X>= 1, X=<5, Y>=12, Y=<15, Region = zharki, !.
area(X, Y, Region) :- X>= 6, X=<9, Y>=11, Y=<15, Region = severny, !.
area(X, Y, Region) :- X>= 10, X=<15, Y>=13, Y=<15, Region = stalber.



exec(map) :- map, !.
exec(tick) :- !, deadzone_counter.
exec(exit) :- write('babay babyansyah'), nl.
%exec(_) :- write('yeee kaga tau ni mo ngapain'), !.

initTry:-
    playerPos(2,10),
    asserta(deadzone_area(0)).

endgame :-
    playerPos(X,Y),
    deadzone_area(A),
    (X@=<A; Y@=<A; Aright is 19-A ,X@>=Aright; Aright is 19-A ,A@>=Aright), !,
    write('cupu lo'),nl.


/*Deadzone*/
deadzone_counter:-
    deadzone_timer(T),T==0,!,
    retract(deadzone_timer(T)),asserta(deadzone_timer(8)),
    deadzone_area(X), Xn is X+1, retract(deadzone_area(X)), assertz(deadzone_area(Xn)).

deadzone_counter:-!.




printPosition(X,Y) :-
  deadzone_area(A),
  (X@=<A; Y@=<A; Aright is 19-A ,X@>=Aright; Aright is 19-A ,Y@>=Aright), !,
  write('X').

printPosition(X,Y) :-
    playerPos(A,B),
    A==X, B==Y, !,
    write('P').

printPosition(_,_) :- write('-').


/* INI TOLONG DIBENERIN YAK */
printMap(19,19) :- printPosition(19,19), nl, !.
printMap(19, Y):- Ynew is Y + 1, printPosition(19,Y), nl, !, printMap(0,Ynew).
printMap(X,Y) :-
    deadzone_area(A),
    (X@=<A; Y@=<A; Aright is 19-A ,X@>=Aright; Aright is 19-A ,Y@>=Aright), !,
    write('X'),
    Xnew is X+1, printMap(Xnew, Y).
printMap(A,B) :-
    playerPos(X,Y),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == Xmin, B == Ymin,
    printPosition(Xmin,Ymin), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
  playerPos(X,Y),
  Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
  A == X, B == Ymin,
  printPosition(X,Ymin), !,
  Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
  playerPos(X,Y),
  Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
  A == Xplus, B == Ymin,
  printPosition(Xplus,Ymin), !,
  Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
  playerPos(X,Y),
  Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
  A == Xmin, B == Y,
  printPosition(Xmin,Y), !,
  Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
  playerPos(X,Y),
  Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
  A == X, B == Y,
  printPosition(X,Y), !,
  Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
  playerPos(X,Y),
  Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
  A == Xplus, B == Y,
  printPosition(Xplus,Y), !,
  Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
  playerPos(X,Y),
  Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
  A == Xmin, B == Yplus,
  printPosition(Xmin,Yplus), !,
  Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
  playerPos(X,Y),
  Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
  A == X, B == Yplus,
  printPosition(X,Yplus), !,
  Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
  playerPos(X,Y),
  Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
  A == Xplus, B == Yplus,
  printPosition(Xplus,Yplus), !,
  Anew is A+1, printMap(Anew,B).

printMap(X,Y) :- Xnew is X + 1, write('-'), !, printMap(Xnew, Y).

map :-
    write('di hutan main kelinci'), nl,
    write('tes map hutan:'), nl, nl,
    printMap(0,0).


 /*Cek apakah move masuk deadzone atau tidak*/
is_able_move(X,_):-deadzone_area(A),X@=<A,!,fail.
is_able_move(_,Y):-deadzone_area(A),Y@=<A,!,fail.
is_able_move(X,_):-deadzone_area(A),Aright is 19-A,X@>=Aright,!,fail.
is_able_move(_,Y):-deadzone_area(A),Aright is 19-A,Y@>=Aright,!,fail.
is_able_move(_,_).

 /*Enter deadzone*/
 /*enter_deadzone:-
  player(X,Y,_,_,_,_,_),
  deadzone_area(A),
  (X@=<A; Y@=<A; Aright is 19-A, X@>=Aright; Aright is 19-A, Y@>=Aright),!,
  write('yah cupu lu masuk deadzone'),nl. */

/* print location player right now */
print_player_nearby :-
    get_position(X,Y), print_player_loc(X,Y), !.

/* INI TOLONG DIBENERIN YAK */
print_format(X,Y):-
    player(X,Y,_,_,_,_,_),
    print_player.
print_format(X,Y):-
    enemy(_,X,Y,_,_),
    print_enemy.
print_format(X,Y):-
    location(X,Y,Item),
    weapon_id(_,Item),
    print_weapon.
print_format(X,Y):-
    location(X,Y,Item),
    type_item(medicine,Item),
    print_medicine.
print_format(X,_):-
    X < 0,
    print_border.
print_format(X,_):-
    X > 9,
    print_border.
print_format(_,Y):-
    Y < 0,
    print_border.
print_format(_,Y):-
    Y > 19,
    print_border.
print_format(X,Y):-
  area(X,Y,Z),
  Z = blank,
  print_inaccessible.
print_format(_,_):-print_accessible.

/* print nearby location */
print_north(X,Y) :-
    area(X,Y,Region), print_nearby_loc(north, Region).
print_south(X,Y) :-
    area(X,Y,Region), print_nearby_loc(south, Region).
print_east(X,Y) :-
    area(X,Y,Region), print_nearby_loc(east, Region).
print_west(X,Y) :-
    area(X,Y,Region), print_nearby_loc(west, Region).

/* INI TOLONG DIBENERIN YAK */
print_nearby_loc(Direction, kantin_borju):-
    format('In the ~w, you see Kantin Borju', [Direction]), nl, !.
print_nearby_loc(Direction, kandom):-
    format('In the ~w, you see Kandang Domba', [Direction]), nl, !.
print_nearby_loc(Direction, intel):-
    format('In the ~w, you see Indonesia Tenggelam', [Direction]), nl, !.
print_nearby_loc(Direction, ruang_rektor):-
    format('In the ~w, you see Ruang Rektor', [Direction]), nl, !.
print_nearby_loc(Direction, labtek_v):-
    format('In the ~w, you see Labtek V', [Direction]), nl, !.
print_nearby_loc(Direction, ruang_ujian):-
    format('In the ~w, you see Test Room', [Direction]), nl, !.
print_nearby_loc(Direction, sadikin):-
    format('In the ~w, you see Sadikin', [Direction]), nl, !.
print_nearby_loc(Direction, perpustakaan):-
    format('In the ~w, you see Library', [Direction]), nl, !.
print_nearby_loc(Direction, sacred_path):-
    format('In the ~w, you see something...', [Direction]), nl, !.
print_nearby_loc(Direction, secret_path):-
    format('In the ~w, you see... Wait.. What is that place?', [Direction]), nl, !.
print_nearby_loc(Direction, blank):-
    format('In the ~w, there\'s restricted place.. You can\'t go there!', [Direction]), nl, !.

* print movement */
print_atas:-
    nl, write('From your place, you move to the north...'), nl.

print_bawah :-
    nl, write('From your place, you move to the south...'), nl.

print_kanan :-
    nl, write('From your place, you move to the east...'), nl.

print_kiri :-
    nl, write('From your place, you move to the west...'), nl.
