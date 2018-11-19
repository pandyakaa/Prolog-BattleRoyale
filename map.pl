/*map*/

area(X, Y, Region) :- X>= 1, X<=4, Y>=1, Y<=5, Region = quarry, !.
area(X, Y, Region) :- X>= 5, X<=9, Y>=1, Y<=5, Region = military_base, !.
area(X, Y, Region) :- X>= 10, X<=15, Y>=1, Y<=7, Region = mylta, !.
area(X, Y, Region) :- X>= 1, X<=5, Y>=6, Y<=11, Region = georgopol, !.
area(X, Y, Region) :- X>= 6, X<=9, Y>=6, Y<=10, Region = pochinki, !.
area(X, Y, Region) :- X>= 10, X<=15, Y>=8, Y<=12, Region = yasnaya, !.
area(X, Y, Region) :- X>= 1, X<=5, Y>=12, Y<=15, Region = zharki, !.
area(X, Y, Region) :- X>= 6, X<=9, Y>=11, Y<=15, Region = severny, !.
area(X, Y, Region) :- X>= 10, X<=15, Y>=13, Y<=15, Region = stalber.

/*Blue Circle, expand for every n-moves*/

blue(X, Y, NMoves) :-NMoves=CountMoves X = -1 + NMoves, Y>=1, Y<=15, 
