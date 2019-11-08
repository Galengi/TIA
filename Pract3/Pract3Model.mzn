%Declaracion de un vector 9 x 2
array [1..9, 1..2] of var 1..18: celda;      % Podemos acceder a cada celda[i, j]

%includes
include "alldifferent.mzn";    

% Todas las celdas en una fila son diferentes.
%constraint    forall  (i in 1..9)  ( alldifferent (j in 1..2) ( celda[i,j] ));
constraint alldifferent (celda);


% a
constraint abs(celda[1,2] - celda[1,1]) != 1 /\ abs(celda[1,2] - celda[5,1]) != 1 /\ abs(celda[1,2] - celda[9,1]) != 1 /\ abs(celda[1,2] - celda[4,2]) != 1;

% b
constraint forall(i in 1..9) (abs(celda[3,1] - (celda[i,1])) != 1);

%c
constraint abs(celda[4,1]-celda[4,2]) >= 5;

%d
constraint abs(celda[8,1]-celda[8,2]) == 2;

%e
constraint abs(celda[5,1]-celda[5,2]) == 1;

%f
constraint abs(celda[4,1]-celda[1,1]) == 1) \/ abs(celda[4,1]-celda[9,1]) == 1) \/ (abs(celda[4,1]-celda[1,2]) == 1) \/ abs(celda[4,1]-celda[9,2]) == 1;

%g
constraint abs(celda[6,1] - celda[7,1]) != 1;

%h
constraint (abs(celda[5,1]-celda[4,2]) == 1) \/ abs(celda[5,1]-celda[8,2]) == 1) \/ (abs(celda[5,1]-celda[2,1]) == 1) \/ abs(celda[5,1]-celda[3,1]) == 1) \/ abs(celda[5,1]-celda[7,1]) == 1) /\ abs(celda[5,2]-celda[6,1]) != 1;

%i
constraint forall(i,j in 1..9 where i > j) (celda[i,1]-celda[j,1] > 0);

%j
constraint forall (i in 1..7, j in 1..9 where i < j) (celda[i,1]-celda[j,1] > 0 /\ i < j /\ i < 7);

