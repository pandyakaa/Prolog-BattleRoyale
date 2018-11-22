:-dynamic(player/7).
:-dynamic(enemy/4).


/*Initial Player Stats*/
initHealth(100).
initArmor(0).
initWeapon(hand).
initInventory([]).
initAmmo([0,0]).


randomCoordinate(X, Y):-
    random(1, 20, A), random(1, 20, B),
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



/*enemy*/

init_enemy(0) :- !.
init_enemy(N) :- generate_enemy(N), M is N-1, init_enemy(M).


generate_enemy(Id):-
  initHealth(Health),
  randomCoordinate(X,Y),
  asserta(enemy(Id, X,Y,Health)).

%health
decrease_HealthE(Amount):-
    enemy(Id,X,Y,Health),
    NewHealth is Health - Amount,
    NewHealth =< 0,
    retract(enemy(Id,X,Y,Health)),
    asserta(enemy(Id,X,Y,0)).

decrease_HealthE(Amount):-
    enemy(Id,X,Y,Health),
    NewHealth is Health - Amount,
    retract(enemy(Id,X,Y,Health)),
    asserta(enemy(Id,X,Y,NewHealth)).

%attack Player
