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
weaponName(0, akm).
weaponName(1, sks).
weaponName(2, kar).
weaponName(3, ump).
weaponName(4, s12k).

/* WEAPON DAMAGE */
weaponDamage(akm,20).
weaponDamage(sks,30).
weaponDamage(kar,50).
weaponDamage(ump,20).
weaponDamage(s12k,70).

/* WEAPON AMMO */
weaponAmmo(1, akm, 30).
weaponAmmo(2, sks, 25).
weaponAmmo(3, kar, 25).
weaponAmmo(4, ump, 40).
weaponAmmo(5, s12k, 8).

/* ITEM TYPE */
itemType(armor, helmet).
itemType(armor, vest).
itemType(armor, belt).
itemType(armor, backpack). /* soon  */
itemType(medicine, painkiller).
itemType(medicine, bandage).
itemType(medicine, aidKit).
itemType(medicine, medKit).
itemType(ammo, akm).
itemType(ammo, sks).
itemType(ammo, kar).
itemType(ammo, ump).
itemType(ammo, s12k).

/* MEDICINE HEAL RATE */
medicineHeal(1, painkiller, 30).
medicineHeal(2, bandage, 50).
medicineHeal(3, aidKit, 75).
medicineHeal(4, medKit, 100).

/* ARMOR STRENGHT */
armorStrength(1, helmet, 20).
armorStrength(2, vest, 50).
armorStrength(4, belt, 10).
/*armorStrength(4, helmet, 20).*/


                            /* ======== DECLARING RULESS ======== */

/* MAP area(X,Y, Region) */
/* INITIALIZING LOCATION OD THE ITEM */
initItems :-
    initWeapon, initMedicine, initArmor, initAmmo, !.

initWeapon :-
    placeWeapon(20), weaponForge(5).

