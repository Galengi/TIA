%Declaracion de un vector 9 x 2
array [1..9, 1..2] of var 1..18: celda;      % Podemos acceder a cada celda[i, j]

%includes
include "alldifferent.mzn";    

% Todas las celdas en una fila son diferentes.
%constraint    forall  (i in 1..9)  ( alldifferent (j in 1..2) ( celda[i,j] ));
constraint alldifferent (celda);


% a
constraint abs(celda[1,2] - celda[1,1]) != 1 /\ abs(celda[1,2] - celda[1,1]) != 1 /\ abs(celda[1,2] - celda[1,1]) != 1 /\ abs(celda[1,2] - celda[1,1]) != 1;