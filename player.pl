:- dynamic(player/6).
:- dynamic(ammo/2).

/*Initial Player Stats*/
initHealth(100).
initArmor(0).
initWeapon(hand).
initInventory([]).
/*Initial Player Ammo*/
init_Ar(0).
init_Smg(0).

randomCoordinate(X, Y):-
    random(1, 20, A), random(1, 20, B),
    X is A, Y is B.


    init_Player:-
        initHealth(Health),
        initArmor(Armor),
        initWeapon(Weapon),
        initInventory(Inventory),
        randomCoordinate(X, Y),
        asserta(player(X,Y,Health,Armor,Weapon,Inventory)), !.

    init_Ammo:-
	init_Ar(Ar_Ammo),
	init_Smg(Smg_Ammo),
	



%Health
    increase_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory),
        NewHealth is Amount+Health,
        NewHealth > 100,
        retract(player(X,Y,Health,Armor,Weapon,Inventory)),
        asserta(player(X,Y,100,Armor,Weapon,Inventory)).
    increase_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory),
        NewHealth is Amount+Health,
        retract(player(X,Y,Health,Armor,Weapon,Inventory)),
        asserta(player(X,Y,NewHealth,Armor,Weapon,Inventory)).

    decrease_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory),
        NewHealth is Health - Amount,
        Armor = 0,
        NewHealth < 0,
        retract(player(X,Y,Health,Armor,Weapon,Inventory)),
        asserta(player(X,Y,0,Armor,Weapon,Inventory)).

    decrease_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory),
        NewHealth is Health - Amount,
        Armor = 0,
        retract(player(X,Y,Health,Armor,Weapon,Inventory)),
        asserta(player(X,Y,NewHealth,Armor,Weapon,Inventory)).

    decrease_Health(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory),
        NewHealth is Health + Armor - Amount,
        decrease_Armor(Armor),
        player(_,_,_,NewArmor,_,_),
        retract(player(X,Y,Health,NewArmor,Weapon,Inventory)),
        asserta(player(X,Y,NewHealth,NewArmor,Weapon,Inventory)).


    health_Status(Health):- player(_,_,Health,_,_,_).


%Armor
    increase_Armor(Amount):-
        player(X,Y,Health,Armor,Weapon,Inventory),
        NewArmor is Amount + Armor,
        retract(player(X,Y,Health,Armor,Weapon,Inventory)),
        asserta(player(X,Y,Health,NewArmor,Weapon,Inventory)).

    decrease_Armor(Amount):-
            player(X,Y,Health,Armor,Weapon,Inventory),
            NewArmor is Armor - Amount,
            NewArmor < 0,
            retract(player(X,Y,Health,Armor,Weapon,Inventory)),
            asserta(player(X,Y,Health,0,Weapon,Inventory)).

    decrease_Armor(Amount):-
            player(X,Y,Health,Armor,Weapon,Inventory),
            NewArmor is Armor - Amount,
            retract(player(X,Y,Health,Armor,Weapon,Inventory)),
            asserta(player(X,Y,Health,NewArmor,Weapon,Inventory)).

/*main for test*/
