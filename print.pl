

print_title :-
  nl,
write('PPPPPPPPPPPPPPPPP   UUUUUUUU     UUUUUUUUBBBBBBBBBBBBBBBBB             JJJJJJJJJJJIIIIIIIIII       '),nl,
write('P::::::::::::::::P  U::::::U     U::::::UB::::::::::::::::B            J:::::::::JI::::::::I       '),nl,
write('P::::::PPPPPP:::::P U::::::U     U::::::UB::::::BBBBBB:::::B           J:::::::::JI::::::::I       '),nl,
write('PP:::::P     P:::::PUU:::::U     U:::::UUBB:::::B     B:::::B          JJ:::::::JJII::::::II       '),nl,
write('  P::::P     P:::::P U:::::U     U:::::U   B::::B     B:::::B            J:::::J    I::::I         '),nl,
write('  P::::P     P:::::P U:::::D     D:::::U   B::::B     B:::::B            J:::::J    I::::I         '),nl,
write('  P::::PPPPPP:::::P  U:::::D     D:::::U   B::::BBBBBB:::::B             J:::::J    I::::I         '),nl,
write('  P:::::::::::::PP   U:::::D     D:::::U   B:::::::::::::BB              J:::::j    I::::I         '),nl,
write('  P::::PPPPPPPPP     U:::::D     D:::::U   B::::BBBBBB:::::B             J:::::J    I::::I         '),nl,
write('  P::::P             U:::::D     D:::::U   B::::B     B:::::BJJJJJJJ     J:::::J    I::::I         '),nl,
write('  P::::P             U:::::D     D:::::U   B::::B     B:::::BJ:::::J     J:::::J    I::::I         '),nl,
write('  P::::P             U::::::U   U::::::U   B::::B     B:::::BJ::::::J   J::::::J    I::::I         '),nl,
write('PP::::::PP           U:::::::UUU:::::::U BB:::::BBBBBB::::::BJ:::::::JJJ:::::::J  II::::::II       '),nl,
write('P::::::::P            UU:::::::::::::UU  B:::::::::::::::::B  JJ:::::::::::::JJ   I::::::::I       '),nl,
write('P::::::::P              UU:::::::::UU    B::::::::::::::::B     JJ:::::::::JJ     I::::::::I       '),nl,
write('PPPPPPPPPP                UUUUUUUUU      BBBBBBBBBBBBBBBBB        JJJJJJJJJ       IIIIIIIIII       '),nl,
write('------------------------------------Selamat Menikmati--------------------------------------------- '),nl.

print_commands :-
nl,
write('              +-+-+-+-+-+-+-+-+'),nl,
write('              |C|o|m|m|a|n|d|s|'),nl,
write('              +-+-+-+-+-+-+-+-+'),nl,
nl,nl,
write('GAME COMMANDS-------------------------------- '),nl,nl,
write('>help.             | '), write('Show list of commands'),nl,
write('>quit.             | '), write('Quit game'),nl,
write('>save.             | '), write('Save game'),nl,
write('>load.             | '), write('Load game'),nl,nl,
write('PLAYER COMMANDS------------------------------ '),nl,nl,
write('>attack.           | '), write('Attack Enemy'),nl,
write('>look.             | '), write('Look around'),nl,
write('>drop(Object).     | '), write('Drop object from inventory'),nl,
write('>take(Object).     | '), write('Take object'),nl,
write('>use(Object).      | '), write('Use object from inventory'),nl,nl,
write('STATUS COMMANDS------------------------------ '),nl,nl,
write('>map.              | '), write('Show map'),nl,
write('>status.           | '), write('Show status'),nl,nl,
write('MOVE COMMANDS-------------------------------- '),nl,nl,
write('>w.                | '), write('Move up'),nl,
write('>s.                | '), write('Move down'),nl,
write('>a.                | '), write('Move left'),nl,
write('>d.                | '), write('Move right'),nl.

/*print player*/
print_inflict_damage(Amount):-
    format('You decrease enemy health by ~w!', [Amount]),nl.

print_decrease_health(Amount) :-
    format('Your enemy dealt ~w damage to you', [Amount]), nl,
    player(_,_,Health,_,_,_,_), format('Your Health: ~w', [Health]), nl.

print_increase_health(Object,Amount) :-
    format('You increased your health ~w by using ~w',[Amount],[Object]),nl,
    player(_,_,Health,_,_,_,_), format('Your Health is now ~w',[Health]),nl.

print_armor_rate(Object,Amount):-
      format('Your Armor is now by using ~w',[Amount],[Object]),nl.

print_player_loc(X,Y) :-
    check_enemy_exist,
    area(X, Y, Region), nl,
    print_loc(Region), write('There\'s an enemy in your sight'), nl, !.

print_player_loc(X,Y) :-
    area(X,Y,Region), nl,
    print_loc(Region), !.

print_loc(quarry):-
    write('Deep, large pits and stone grounds are around you. You are in quarry!'), nl, !.
print_loc(military_base):-
    write('You see military facilities and training fields. You are in military base!'), nl, !.
print_loc(mylta):-
    write('A lot of power reactors around. You are in mylta'), nl, !.
print_loc(georgopol):-
    write('A lot of Containers and bases are around you. You are in georgopol'), nl, !.
print_loc(pochinki):-
    write('You sense an intense air of war in here. You are in pochinki'), nl, !.
print_loc(yasnaya):-
    write('The area is full of abandoned houses and apartments. You are in yasnaya'), nl, !.
print_loc(zharki):-
    write('Houses complex at the edge of a lake. You are in zharki'), nl, !.
print_loc(severny):-
    write('This is where all road meets. You are in severny'), nl, !.
print_loc(stalber):-
    write('This island seems empty with an abandoned observatory. You are in stalber'), nl, !.

    /* print items in your location right now */
    print_items_loc(X, Y) :-
        location(X, Y, Item),
        print_item_loc(X, Y), !.
    print_items_loc(_, _) :-
        write('No item around'), nl.

    print_item_loc(X, Y) :-
        location(X, Y, Item),
        print_item(Item), nl,
        fail.
    print_item_loc(_, _) :- !.

    print_item(Item) :-
        itemType(Type, Item), print_itemType(Type, Item).

    print_itemType(armor, Item) :-
        format('You see ~w, you can use it as an armor', [Item]), !.
    print_itemType(ammo, Item) :-
        format('You see ~w ammo, you can use it to reload weapon', [Item]), !.
    print_itemType(weapon, Item) :-
        format('You see ~w, you can use it as a weapon', [Item]), !.
    print_itemType(medicine, Item) :-
        format('You see ~w, you can use it to increase your health', [Item]).

print_atas :-
    nl, write('You moved up'), nl.

print_bawah :-
    nl, write('You moved down'), nl.

print_kanan :-
    nl, write('You moved right'), nl.

print_kiri :-
    nl, write('You moved left'), nl.

print_status:-
      player(X,Y,Health,Armor,Weapon,Inventory,Ammo),
      A is X+1, B is Y +1,
      format('You are at (~d,~d)',[A,B]),nl,
      write('Health                 :'),write(Health),nl,
      write('Armor                  :'),write(Armor),nl,
      write('Current Weapon         :'),write(Weapon),nl,
      write('Inventory              :'),write(Inventory),nl,
      write('Ammo [Ar,Smg]          :'),write(Ammo),nl.

/* print fail attack */
fail_attack :-
    nl, write('There\'s no enemy in your sight !'), nl.

/* print fail move */
fail_move :-
    nl, write('You can\'t move!'), nl.
