/*

Decisiones en Prolog

*/


/*

19) Definir un predicado ternario "mayor_o_igual" que relaciona dos números con el mayor
de ambos, o con uno de ellos si son iguales.

*/

mayorOIgual(NumeroUno, NumeroDos, NumeroUno):-
    NumeroUno > NumeroDos.

mayorOIgual(_, Numero, Numero).

/*

21) Definir un predicado unario "par" que es verdadero cuando su único sujeto es un
número par.


*/

par(Numero):-
    Numero mod 2 =:= 0.

/*

22) Definir un predicado binario "paridad" que relaciona un número con la palabra "par" si
el número es par, o con la palabra "impar" de otro modo.

*/

paridad(Numero, 0):-
    Numero mod 2 =:= 0.

paridad(_, 1).

/*

32) Escribir un predicado que relacione una hora dada en horas, minutos y segundos con
la hora será un segundo después

*/

pasarASegundos(Hora, Minutos, Segundos, Resultado):-
    Resultado is (Hora * 3600) + (Minutos * 60) + Segundos.

pasarAHoras(Segundos, Resto, Horas):-
    Segundos >= 3600,
    Resto is (Segundos mod 3600),
    Horas is (Segundos // 3600).

pasarAHoras(Segundos, Segundos, 0).

pasarAMinutos(Segundos, Resto, Minutos):-
    Segundos >= 60,
    Resto is (Segundos mod 60),
    Minutos is (Segundos // 60).

pasarAMinutos(Segundos, Segundos, 0).

pasarAHMS(EnSegundos, Horas, Minutos, Segundos):-
    pasarAHoras(EnSegundos, RestoHora, Horas),
    pasarAMinutos(RestoHora, Segundos, Minutos).

horaDespues(Hora, Minutos, Segundos, HoraNueva, MinutosNuevos, SegundosNuevos):-
    pasarASegundos(Hora, Minutos, Segundos, Resultado),
    NuevoResultado is (Resultado + 1),
    pasarAHMS(NuevoResultado, HoraNueva, MinutosNuevos, SegundosNuevos).

/*

33) Dados los siguientes datos sobre jugadores de basket:
cantidad_de_dobles(juan, 15).
...
cantidad_de_triples(jose, 5).
...
cantidad_de_infracciones(juan, 6).
...
que representan la cantidad de dobles, triples e infracciones de los jugadores a
lo largo del campeonato, se requiere un predicado que relacione el nombre de
un jugador con alguna de las siguientes categorías:

● Posible NBA, cuando el jugador hizo al menos 10 triples, 30 dobles y
cometió menos de 5 infracciones.

● Bueno, cuando el jugador hizo al menos 20 dobles y cometió menos de
8 infracciones.

● Regular, cuando el jugador hizo al menos 10 dobles y cometió menos de
12 infracciones.

● Desastroso, cuando el jugador hizo menos de 10 dobles y cometió 12 o
más infracciones.

*/

cantidad_de_triples(juan, 5).
cantidad_de_triples(martin, 20).
cantidad_de_triples(pablo, 5).

cantidad_de_dobles(juan, 15).
cantidad_de_dobles(martin, 35).
cantidad_de_dobles(pablo, 5).

cantidad_de_infracciones(juan, 6).
cantidad_de_infracciones(martin, 2).
cantidad_de_infracciones(pablo, 18).

categoria(Triples, Dobles, Infracciones, posibleNBA):-
    Triples >= 10,
    Dobles >= 30,
    Infracciones < 5.

categoria(_, Dobles, Infracciones, bueno):-
    Dobles >= 20,
    Infracciones < 8.

categoria(_, Dobles, Infracciones, regular):-
    Dobles >= 10,
    Infracciones < 12.
    
categoria(_, Dobles, Infracciones, desastroso):-
    Dobles < 10,
    Infracciones >= 12.

verCategoria(Nombre, Categoria):-
    cantidad_de_triples(Nombre, Triples),
    cantidad_de_dobles(Nombre, Dobles),
    cantidad_de_infracciones(Nombre, Infracciones),
    categoria(Triples, Dobles, Infracciones, Categoria).

jugador(Nombre, Categoria):-
    verCategoria(Nombre, Categoria).

/*

36) Dada la siguiente base de hechos:

Escribir un predicado que relacione una fecha con el empleado que se encuentra de
vacaciones. Por Ej.
?- enVacaciones(15,2, Empleado).
Empleado = pedro;
Empleado = roberto;
false.
?- enVacaciones(15,3, Empleado).
Empleado = nadie."

*/

% diasVacaciones(empleado, dias).
diasVacaciones(juan,20).
diasVacaciones(pedro,30).
diasVacaciones(carlos,15).
diasVacaciones(roberto,20).

%comienzoVacaciones(empleado, diaComienzoVacaciones, mesComienzoVacaciones).
comienzoVacaciones(juan, 9, 1).
comienzoVacaciones(pedro, 1, 2).
comienzoVacaciones(carlos, 20, 1).
comienzoVacaciones(roberto, 10, 2).

toCantidadDeDias(Dia, Mes, TotalDeDias):-
    TotalDeDias is ((Mes - 1) * 30) + Dia.

fechaVacacionesEmpleado(Empleado, FechaInicio, FechaFin):-
    comienzoVacaciones(Empleado, DiaInicio, MesInicio),
    diasVacaciones(Empleado, CantidadDeDias),
    toCantidadDeDias(DiaInicio, MesInicio, FechaInicio),
    FechaFin is (FechaInicio + CantidadDeDias).    

enVacaciones(Dia, Mes, Empleado):-
    toCantidadDeDias(Dia, Mes, FechaActual),
    fechaVacacionesEmpleado(Empleado, FechaInicio, FechaFin),
    FechaInicio =< FechaActual,
    FechaActual =< FechaFin.

/* 

Escribe un proceso recursivo que permita decidir si un número natural N es divisible por 11. 
Dado que se sabe que un número es divisible entre 11, si y solo si la suma de los digitos de 
posición par menos la suma de los dígitos de posición impar es un múltiplo de 11. 
Por ejemplo: sea N = 2341675, entonces (5 + 6 + 4 + 2) - (7 + 1 + 3) = 6, que no es múltiplo de 11, 
por lo tanto N no es divisible entre 11. 

*/

esDivisiblePor11(Numero):-
    esDivisible(Numero, impar, 0, 0).

% Caso base
esDivisible(0, _, Suma, Suma).

% Caso resultado de la resta mayor a 0
esDivisible(0, _, SumaDePares, SumaDeImpares):- 
    TotalParcial is abs(SumaDePares - SumaDeImpares),
    TotalParcial >= 11,
    esDivisiblePor11(TotalParcial).

% Posiciones pares 
esDivisible(Numero, par, SumaDePares, SumaDeImpares):-
    Numero > 0,
    Resto is (Numero mod 10),
    SumaParcial is SumaDePares + Resto,
    NuevoNumero is (Numero // 10),
    esDivisible(NuevoNumero, impar, SumaParcial, SumaDeImpares).
    
% Posiciones impares 
esDivisible(Numero, impar, SumaDePares, SumaDeImpares):-
    Numero > 0,
    Resto is (Numero mod 10),
    SumaParcial is SumaDeImpares + Resto,
    NuevoNumero is (Numero // 10),
    esDivisible(NuevoNumero, par, SumaDePares, SumaParcial).

/*

a) Escribir un predicado que relacione a un equipo con los equipos que les haya hecho
goles.
Por Ejemplo:
?- golesDeVisitante(sospechososDeNunca, Equipo).
Equipo = sacaChispasDeChocolate;
false.

*/

%partido(EquipoLocal, GolesEquipoLocal, EquipoVisitante, GolesEquipoVisitante).
partido(sacaChispasDeChocolate, 3, locosDelBalon, 2).
partido(sospechososDeNunca, 1, turcosEnLaNeblina, 5).
partido(turcosEnLaNeblina, 2, sacaChispasDeChocolate,2).
partido(locosDelBalon, 2, sospechososDeNunca, 0).
partido(sacaChispasDeChocolate, 2, sospechososDeNunca, 1).
partido(locosDelBalon, 2, turcosEnLaNeblina, 4).

golesDeVisitante(EquipoVisitante, EquipoLocal):-
    partido(EquipoLocal, _, EquipoVisitante, GolesEquipoVisitante),
    GolesEquipoVisitante > 0.

/*

b) Escribir un predicado que relaciones 1 equipo con los puntos que sacó en el partido
frente a otro equipo.
Nota= El que gana se lleva 3 puntos, el empate da 1 punto a cada equipo y 0 para el
perdedor
Por ejemplo:
%puntos(Equipo1,EquipoContrario, PuntosDelEquipo1).
?- puntos(sacaChispasDeChocolate, turcosEnLaNeblina,Puntos).
Puntos = 1.
?- puntos(sacaChispasDeChocolate, EquipoContrario, 3).
EquipoContrario = locosDelBalon;
EquipoContrario = sospechososDeNunca.

*/

% Caso si gana.
puntos(EquipoLocal, EquipoVisitante, Puntos):-
    partido(EquipoLocal, GolesEquipoLocal, EquipoVisitante, GolesEquipoVisitante),
    partido(EquipoVisitante, GolesEquipoVisitante, EquipoLocal, GolesEquipoLocal),
    GolesEquipoLocal > GolesEquipoVisitante,
    Puntos is 3.

% Caso si pierde.
puntos(EquipoLocal, EquipoVisitante, Puntos):-
    partido(EquipoLocal, GolesEquipoLocal, EquipoVisitante, GolesEquipoVisitante),
    partido(EquipoVisitante, GolesEquipoVisitante, EquipoLocal, GolesEquipoLocal),
    GolesEquipoLocal < GolesEquipoVisitante,
    Puntos is 0.

% Caso si empata.
puntos(EquipoLocal, EquipoVisitante, Puntos):-
    partido(EquipoLocal, GolesEquipoLocal, EquipoVisitante, GolesEquipoVisitante),
    partido(EquipoVisitante, GolesEquipoVisitante, EquipoLocal, GolesEquipoLocal),
    GolesEquipoLocal =:= GolesEquipoVisitante,
    Puntos is 1.

/*

c) Escribir un predicado que relacione a un equipo con los equipos le ganó.
Por Ejemplo:
?- leGano(turcosEnLaNeblina, Equipo).
Equipo = sospechososDeNunca;
Equipo = locosPorElBalon.
?- leGano(Equipo,turcosEnLaNeblina).
false.
Nota= Nadie le ganó a turcosEnLaNeblina

*/

leGano(EquipoLocal, EquipoVisitante):-
    partido(EquipoLocal, GolesEquipoLocal, EquipoVisitante, GolesEquipoVisitante),
    GolesEquipoLocal > GolesEquipoVisitante.

leGano(EquipoLocal, EquipoVisitante):-
    partido(EquipoVisitante, GolesEquipoVisitante, EquipoLocal, GolesEquipoLocal),
    GolesEquipoLocal > GolesEquipoVisitante.

/*

d) Escribir un predicado que relacione 2 equipos que hayan jugado un partido que
terminó en empate.
Por Ejemplo:
?- empate(Local,Visitante).
Local = turcosEnLaNeblina,
Visitante = sacaChispasDeChocolate ;
false.

*/

empate(EquipoLocal, EquipoVisitante):-
    partido(EquipoLocal, GolesEquipoLocal, EquipoVisitante, GolesEquipoVisitante),
    GolesEquipoLocal =:= GolesEquipoVisitante.

empate(EquipoLocal, EquipoVisitante):-
    partido(EquipoVisitante, GolesEquipoVisitante, EquipoLocal, GolesEquipoLocal),
    GolesEquipoLocal =:= GolesEquipoVisitante.