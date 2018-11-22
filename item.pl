:- dynamic(location/3).
:- dynamic(player/7).
/* ITEM */ 

/*
WEAPON		
NAME	DAMAGE	AMMO
AKM	20	30
SKS	30	25
KAR	50	25
UMP	20	40
S12K	70	8
*/
                            /* ======== DECLARING FACTS ======== */
/* WEAPON NAME */
weaponName(1, akm).
weaponName(2, sks).
weaponName(3, kar).
weaponName(4, ump).
weaponName(5, uzi).

/* WEAPON DAMAGE */
weaponDamage(akm,20).
weaponDamage(sks,30).
weaponDamage(kar,50).
weaponDamage(ump,20).
weaponDamage(uzi,20).

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
    initWeapon(20), initWeaponForge(5).

/* RANDOM WEAPON */
randomWeapon :-
    repeat,
    random(1, 5, N), weaponName(N, A),
    random(0, 20, X), random(0, 20, Y),
    grid(X, Y, Loc), Loc \== blank,
    asserta(location(X,Y,A)).


randomWeaponForge :-
    random(1, 5, N), weaponName(N,A),
    random(7, 20, X), random(17, 20, Y),
    asserta(location(X,Y,A)).


/* LOCATION OF WEAPON */
initWeapon(0) :-!.
initWeapon(N) :- 
    randomWeapon,
    M is N-1,
    initWeapon(M).

initWeaponForge(0) :- !.
initWeaponForge(N) :- 
    randomWeaponForge,
    M is N-1,
    initWeaponForge(M).


/* INITIALIZIG MAP WITH MEDICINE */
randomMedicine :-
    repeat,
    random(1,5, N), medicineHeal(N, A, _),
    random(0, 20, X), random(0, 20, Y),
    grid(X, Y, Loc),
    Loc \== blank,
    asserta(location(X,Y,A)).

initMedicine(0) :- !.
initMedicine(N) :- 
    randomMedicine,
    M is N-1,
    initMedicine(M).

initAllMedicine:-
    initMedicine(20).


/* INITIALIZING ARMOR */
randomArmor:-
    repeat,
    random(1, 3, N), armorStrength(N, A, _),
    random(0, 20, X), random(0,20, Y),
    grid(X,Y,Loc),
    Loc \== blank,
    asserta(location(X,Y,A)).

initArmor(0) :- !.
initArmor(N) :-
    randomArmor,
    M is N-1,
    initArmor(M).

initAllArmor:-
    initArmor(20).



/* INITIALIZING AMMO */
randomAmmo:-
    repeat,
    random(1, 3, N), ammoReload(N, A, _),
    random(0, 20, X), random(0,20, Y),
    grid(X,Y,Loc),
    Loc \== blank,
    asserta(location(X,Y,A)).

initAmmo(0) :- !.
initAmmo(N) :-
    randomAmmo,
    M is N-1,
    initAmmo(M).

initAllAmmo:-
    initAmmo(20).



/* INITIALIZING LOCATION OD THE ITEM */
initItems :-
    initAllWeapon, initAllMedicine, initAllArmor, initAllAmmo, !.


/* MEDICINE EFFECT */
medicineEffect(X) :- 
    medicineHeal(_, X, N),
    increase_Health(N).

/* SET ARMOR */
armorEffect(X) :-
    armorStrength(_, X, N),
    set_Armor(N).

