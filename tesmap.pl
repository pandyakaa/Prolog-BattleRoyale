/*map*/

:- dynamic(deadzone_area/1).
:- dynamic(deadzone_timer/1).
:- dynamic(playerPos/2).

area(X, Y, Region) :- X>= 0, X=<4, Y>=0, Y=<5, Region = quarry, !.
area(X, Y, Region) :- X>= 5, X=<9, Y>=0, Y=<5, Region = military_base, !.
area(X, Y, Region) :- X>= 10, X=<19, Y>=0, Y=<7, Region = mylta, !.
area(X, Y, Region) :- X>= 0, X=<5, Y>=6, Y=<11, Region = georgopol, !.
area(X, Y, Region) :- X>= 6, X=<9, Y>=6, Y=<11, Region = pochinki, !.
area(X, Y, Region) :- X>= 10, X=<19, Y>=8, Y=<12, Region = yasnaya, !.
area(X, Y, Region) :- X>= 0, X=<5, Y>=12, Y=<19, Region = zharki, !.
area(X, Y, Region) :- X>= 6, X=<9, Y>=12, Y=<19, Region = severny, !.
area(X, Y, Region) :- X>= 10, X=<19, Y>=13, Y=<19, Region = stalber.



exec(map) :- map, !.
exec(tick) :- !, deadzone_counter.
exec(exit) :- write('babay babyansyah'), nl.
%exec(_) :- write('yeee kaga tau ni mo ngapain'), !.

initTry:-
    playerPos(2,10),
    asserta(deadzone_area(0)).

endGame :-
    player(X,Y,_,_,_,_,_),
    deadzone_area(A),
    (X@=<A; Y@=<A; Aright is 19-A ,X@>=Aright; Aright is 19-A ,A@>=Aright), !,
    write('ngapain masuk deadzone dah. mati kan lo'),nl.

endGame :-
    player(_, _, Health, _, _, _, _),
    Health==0, !,
    write('yaelah main game gini doang mati lo'),nl.
  
/*endGame :-
    is_enemy_all_dead, !,
    write('Selamat Skidipapman berhasil bertahan hidup'),nl.*/


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
    player(A, B, _, _, _, _, _),
    A==X, B==Y, !,
    write('P').

printPosition(X,Y) :-
    location(A,B, Item),
    itemType(medicine, Item),
    A==X, B==Y, !,
    write('M').

printPosition(X,Y) :-
    location(A, B, Item),
    itemType(armor, Item),
    A==X, B==Y, !,
    write('R').

printPosition(X,Y) :-
    location(A,B, Item),
    itemType(ammo,  Item),
    A==X, B==Y, !,
    write('A').

printPosition(X,Y) :-
    location(A,B, Item),
    itemType(weapon, Item),
    A==X, B==Y, !,
    write('W').

printPosition(X,Y) :-
    enemy(_, A, B, _),
    A==X, B==Y, !,
    write('E').

printPosition(_,_) :- write('-').



/* LOOK */
printLook(X,Y) :-
    deadzone_area(A),
    (X@=<A; Y@=<A; Aright is 19-A ,X@>=Aright; Aright is 19-A ,Y@>=Aright), 
    write('X').

printLook(X,Y) :-
    player(X, Y, _, _, _, _, _),
    write('P').

printLook(X,Y) :-
    location(X,Y, Item),
    itemType(medicine, Item),
    write('M').

printLook(X,Y) :-
    location(X, Y, Item),
    itemType(armor, Item),
    write('R').

printLook(X,Y) :-
    location(X,Y, Item),
    itemType(ammo,  Item),
    write('A').

printLook(X,Y) :-
    location(X,Y, Item),
    itemType(weapon, Item),
    write('W').

printLook(X,Y) :-
    enemy(_, X, Y, _),
    write('E').

printLook(X,Y) :- write('-').

/* LOOK 2 */


/* INI TOLONG DIBENERIN YAK */
printMap(19,19) :- printPosition(19,19), nl, !.
printMap(19, Y):- Ynew is Y + 1, printPosition(19,Y), nl, !, printMap(0,Ynew).
printMap(X,Y) :-
    deadzone_area(A),
    (X@=<A; Y@=<A; Aright is 19-A ,X@>=Aright; Aright is 19-A ,Y@>=Aright), !,
    write('X'),
    Xnew is X+1, printMap(Xnew, Y).
printMap(X,Y) :-
    printPosition(X,Y), !,
    Xnew is X + 1, printMap(Xnew,Y).
/*printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == Xmin, B == Ymin,
    printPosition(Xmin,Ymin), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == X, B == Ymin,
    printPosition(X,Ymin), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == Xplus, B == Ymin,
    printPosition(Xplus,Ymin), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == Xmin, B == Y,
    printPosition(Xmin,Y), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == X, B == Y,
    printPosition(X,Y), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == Xplus, B == Y,
    printPosition(Xplus,Y), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == Xmin, B == Yplus,
    printPosition(Xmin,Yplus), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == X, B == Yplus,
    printPosition(X,Yplus), !,
    Anew is A+1, printMap(Anew,B).
printMap(A,B) :-
    player(X,Y,_,_,_,_,_),
    Xmin is X-1, Xplus is X+1, Ymin is Y-1, Yplus is Y+1,
    A == Xplus, B == Yplus,
    printPosition(Xplus,Yplus), !,
    Anew is A+1, printMap(Anew,B).*/

printMap(X,Y) :- Xnew is X + 1, write('-'), !, printMap(Xnew, Y).

map :-
    write('di hutan main kelinci'), nl,
    write('map hutan:'), nl, nl,
    %player(X,Y, _, _, _, _, _),
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


printMapLook(X,Y) :- 
    player(A,B, _, _, _, _, _),
    X is A-1, Y is B-1,!,
    printLook(X,Y).

printMapLook(X,Y) :-
    player(A,B, _, _, _, _, _),
    X is A, Y is B-1, !,
    printLook(X,Y).

printMapLook(X,Y) :-
    player(A,B, _, _, _, _, _),
    X is A+1, Y is B-1, !,
    printLook(X,Y).

printMapLook(X,Y) :-
    player(A,B, _, _, _, _, _),
    X is A-1, Y is B, !,
    printLook(X,Y).

printMapLook(X,Y) :-
    player(A,B, _, _, _, _, _),
    X is A, Y is B, !,
    printLook(X,Y).

printMapLook(X,Y) :-
    player(A,B, _, _, _, _, _),
    X is A+1, Y is B, !,
    printLook(X,Y).

printMapLook(X,Y) :-
    player(A,B, _, _, _, _, _),
    X is A-1, Y is B+1, !,
    printLook(X,Y).

printMapLook(X,Y) :-
    player(A,B, _, _, _, _, _),
    X is A, Y is B+1, !,
    printLook(X,Y).

printMapLook(X,Y) :-
    player(A,B, _, _, _, _, _),
    X is A+1, Y is B+1, !,
    printLook(X,Y).

printMapLook(_,_) :-
    write('-').

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
print_nearby_loc(Direction, quarry):-
    format('In the ~w, you see Quarry', [Direction]), nl, !.
print_nearby_loc(Direction, military_base):-
    format('In the ~w, you see Military Base', [Direction]), nl, !.
print_nearby_loc(Direction, mylta):-
    format('In the ~w, you see Mylta', [Direction]), nl, !.
print_nearby_loc(Direction, georgopool):-
    format('In the ~w, you see Georgopool', [Direction]), nl, !.
print_nearby_loc(Direction, pochinki):-
    format('In the ~w, you see Pochinki', [Direction]), nl, !.
print_nearby_loc(Direction, yasnaya):-
    format('In the ~w, you see Yasnaya', [Direction]), nl, !.
print_nearby_loc(Direction, zharki):-
    format('In the ~w, you see Zharki', [Direction]), nl, !.
print_nearby_loc(Direction, severny):-
    format('In the ~w, you see Severny', [Direction]), nl, !.
print_nearby_loc(Direction, stalber):-
    format('In the ~w, you see Stalber', [Direction]), nl, !.
print_nearby_loc(Direction, _) :-
    format('in the ~w you see unknown area', [Direction]), nl, !.