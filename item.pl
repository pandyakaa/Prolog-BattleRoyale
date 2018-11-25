:- dynamic(location/3).
/* ITEM */

/*
WEAPON
NAME	DAMAGE	AMMO
AKM	20	30
SKS	30	25`
KAR	50	25`
UMP	20	40
S12K	70	8
*/
                            /* ======== DECLARING FACTS ======== */
/*WEAPON AMMO*/

weaponAmmo(ar,akm).
weaponAmmo(ar,sks).
weaponAmmo(ar,kar).
weaponAmmo(smg,ump).
weaponAmmo(smg,uzi).


/* WEAPON NAME */
weaponName(1, akm).
weaponName(2, sks).
weaponName(3, kar).
weaponName(4, ump).
weaponName(5, uzi).

/* WEAPON DAMAGE */
weaponDamage(akm,30).
weaponDamage(sks,40).
weaponDamage(kar,60).
weaponDamage(ump,30).
weaponDamage(uzi,30).

/* AMMO NAME */
ammoName(1, ar).
ammoName(2, smg).

/* RELOAD AMMO */
ammoReload(1, ar, 30).
ammoReload(2, smg, 30).

/* ITEM TYPE */
itemType(armor, helmet).
itemType(armor, vest).
itemType(armor, belt).
itemType(armor, backpack). /* soon  */
itemType(medicine, painkiller).
itemType(medicine, bandage).
itemType(medicine, aidKit).
itemType(medicine, medKit).
itemType(ammo, ar).
itemType(ammo, smg).
itemType(weapon, akm).
itemType(weapon, sks).
itemType(weapon, kar).
itemType(weapon, ump).
itemType(weapon, uzi).


/* MEDICINE HEAL RATE */
medicineHeal(1, painkiller, 30).
medicineHeal(2, bandage, 50).
medicineHeal(3, aidKit, 75).
medicineHeal(4, medKit, 100).

/* ARMOR STRENGHT */
armorStrength(1, helmet, 20).
armorStrength(2, vest, 50).
armorStrength(3, belt, 10).


                            /* ======== DECLARING RULESS ======== */

/* MAP area(X,Y, Region) */

/* INITIALIZING MAP WITH WEAPON */
initAllWeapon :-
    init_weapon(20), init_weaponForge(5).

/* RANDOM WEAPON */
randomWeapon :-
    repeat,
    random(1, 5, N), weaponName(N, A),
    random(0, 19, X), random(0, 19, Y),
    area(X, Y, Loc), Loc \== blank,
    asserta(location(X,Y,A)).


randomWeaponForge :-
    random(1, 5, N), weaponName(N,A),
    random(7, 19, X), random(17, 19, Y),
    asserta(location(X,Y,A)).


/* LOCATION OF WEAPON */
init_weapon(0) :-!.
init_weapon(N) :-
    randomWeapon,
    M is N-1,
    init_weapon(M).

init_weaponForge(0) :- !.
init_weaponForge(N) :-
    randomWeaponForge,
    M is N-1,
    init_weaponForge(M).


/* INITIALIZIG MAP WITH MEDICINE */
randomMedicine :-
    repeat,
    random(1,5, N), medicineHeal(N, A, _),
    random(0, 19, X), random(0, 19, Y),
    area(X, Y, Loc),
    Loc \== blank,
    asserta(location(X,Y,A)).

init_Medicine(0) :- !.
init_Medicine(N) :-
    randomMedicine,
    M is N-1,
    init_Medicine(M).

initAllMedicine:-
    init_Medicine(20).


/* INITIALIZING ARMOR */
randomArmor:-
    repeat,
    random(1, 3, N), armorStrength(N, A, _),
    random(0, 19, X), random(0, 19, Y),
    area(X,Y,Loc),
    Loc \== blank,
    asserta(location(X,Y,A)).

init_armor(0) :- !.
init_armor(N) :-
    randomArmor,
    M is N-1,
    init_armor(M).

initAllArmor:-
    init_armor(20).



/* INITIALIZING AMMO */
randomAmmo:-
    repeat,
    random(1, 3, N), ammoReload(N, A, _),
    random(1, 19, X), random(1,19, Y),
    area(X,Y,Loc),
    Loc \== blank,
    asserta(location(X,Y,A)).

init_Ammo(0) :- !.
init_Ammo(N) :-
    randomAmmo,
    M is N-1,
    init_Ammo(M).

initAllAmmo:-
    init_Ammo(20).



/* INITIALIZING LOCATION OD THE ITEM */
initItems :-
    initAllWeapon, initAllMedicine, initAllArmor, initAllAmmo, !.
