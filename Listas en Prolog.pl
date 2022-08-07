
/*

Listas en Prolog.

*/

/*

1) Predicado que relaciona una lista numérica de dos elementos con otra lista con esos
dos elementos ordenados de menor a mayor.
?- acomodados( [5, 8], X).
X = [5, 8]
?- acomodados( [8, 5], X).
X = [5, 8]

*/

acomodados([Elemento1, Elemento2], [Elemento1, Elemento2]):-
    Elemento1 < Elemento2.

acomodados([Elemento1, Elemento2], [Elemento2, Elemento1]).

/*

2) Predicado que vincula una lista de números enteros, con la cantidad de números
naturales que contiene.
?- naturales([6, -7, -4, 3, 2, 8], X).
X = 4

*/

% Caso base.
naturales([], 0).

% Caso si el elemento de la cabeza es natural.
naturales([Cabeza|Cola], CantidadDeNaturales):-
    Cabeza > 0,
    integer(Cabeza),
    naturales(Cola, CantidadDeNaturalesParcial),
    CantidadDeNaturales is CantidadDeNaturalesParcial + 1.

% Caso si el elemento de la cabeza no es natural.
naturales([_|Cola], CantidadDeNaturales):-
    naturales(Cola, CantidadDeNaturales).

/*

3) Predicado que relaciona una lista de temperaturas con la cantidad de temperaturas
que se encuentran entre los 10º y los 20º.
?- cantidadBajoCero([15, 20, -2, -3, 14, 32], X).
X = 2

*/
cantidadBajoCero([], 0).

cantidadBajoCero([Cabeza|Cola], CantidadQueCumplen):-
    Cabeza >= 10,
    Cabeza =< 20,
    cantidadBajoCero(Cola, CantidadQueCumplenParcial),
    CantidadQueCumplen is CantidadQueCumplenParcial + 1. 

cantidadBajoCero([_|Cola], CantidadQueCumplen):-
    cantidadBajoCero(Cola, CantidadQueCumplen).

/*

4) Predicado que vincula una lista numérica, con la suma de sus elementos.
?- suma([6, 7, 4, 3, 2, 8], X).
X = 30

*/

suma([], 0).

suma([Cabeza|Cola], TotalSuma):-
    suma(Cola, TotalSumaParcial),
    TotalSuma is Cabeza + TotalSumaParcial.

/*

5) Predicado "estaEntre", que vincula dos números enteros "m" y "n", con la lista de los
enteros mayores o iguales que "m" y menores o iguales que "n".
?- estaEntre(2, 5, L).
L = [2, 3, 4, 5]

*/

% Caso base.
estaEntre(ElementoFin, ElementoFin, [ElementoFin]).

% Caso si ElementoInicio es menor a ElementoFin.
estaEntre(ElementoInicio, ElementoFin, ListaDeNaturales):-
    ElementoInicio < ElementoFin,
    NuevoElementoInicio is ElementoInicio + 1,
    estaEntre(NuevoElementoInicio, ElementoFin, ListaDeNaturalesParcial),
    append([ElementoInicio], ListaDeNaturalesParcial, ListaDeNaturales).
    
/*

6) Predicado unario que es verdadero cuando su sujeto es una lista numérica ordenada
en forma creciente.
?- ordenada([3, 6, 8]).
YES
?- ordenada([6, 3, 8]).
FAIL

*/

ordenada([]).
 
ordenada([Elemento]) :-
	atomic(Elemento).

ordenada([Elemento1, Elemento2|Cola]) :-
	Elemento1 < Elemento2,
	ordenada([Elemento2|Cola]).

/*

7) Predicado que relaciona una lista cualquiera con el elemento que se encuentra en el
último lugar.
?- ultimo([a, b, c, r, f, h], X).
X = h

*/

ultimo([], []).

ultimo([UltimoElemento], UltimoElemento).

ultimo([_|Cola], UltimoElemento):-
    ultimo(Cola, UltimoElemento).

/*

8) Predicado cuyos sujetos son dos listas, y que es verdadero cuando la primera lista es
un subconjunto de la segunda.
?- subconjunto([d, a, b], [m, b, f, r, d, a]).
YES
?- subconjunto([d, a, b], [m, k, f, r, d, a]).
FAIL

*/

% Caso que se llegue al final de la lista y no se encuentre el elemento.
pertenece(_, []):-
    false.

% Caso de que se encuentre el elemento.
pertenece(Elemento, [Elemento|_]).

pertenece(Elemento, [_|Cola]):-
    pertenece(Elemento, Cola).    


subConjunto(Lista, Lista).

subConjunto([], _).

subConjunto([CabezaListaUno|ColaListaUno], ListaDos):-
    pertenece(CabezaListaUno, ListaDos),
    subConjunto(ColaListaUno, ListaDos).

/*

9) Predicado que relaciona dos listas con una tercera, formada con los elementos de
ambas.
?- concatenadas([d, a, b], [m, k, f, r, d, a], X).
X = [d, a, b, m, k, f, r, d, a]       

*/

concatenadas([], [], _).

concatenadas([], ListaDos, ListaDos).

concatenadas([CabezaListaUno|ColaListaUno], ListaDos, [CabezaListaUno|ColaListaConcatenada]):-
    concatenadas(ColaListaUno, ListaDos, ColaListaConcatenada).

/*

10) Predicado que relaciona una lista L1 con otra lista L2, con los mismos elementos que
L1, pero rotados un lugar a la izquierda.
?- rotada1([a, b, c, d], X).
X = [b, c, d, a]

*/

rotada1([Cabeza|Cola], ColaRotada):-
    append(Cola, [Cabeza], ColaRotada).

/*

11) Predicado que relaciona una lista L1 con otra lista L2, con los mismos elementos que
L1, pero rotados N lugares a la izquierda.
?- rotadan(4, [a, b, c, d, e, f, g, h, i, j], X).
X = [e, f, g, h, i, j, a, b, c, d]

*/

rotadaN(0, ListaRotada, ListaRotada).

rotadaN(CantidadDeRotaciones, ListaARotar, ListaRotada):-
    NuevaCantidadDeRotaciones is CantidadDeRotaciones - 1,
    rotada1(ListaARotar, ListaRotadaParcial),
    rotadaN(NuevaCantidadDeRotaciones, ListaRotadaParcial, ListaRotada).

/*

12) Predicado que relaciona una lista L1 y un elemento A perteneciente a la misma, con
otra lista L2, formada con los mismos elementos de L1, menos A.
?- menos1(d, [a, b, c, d, e, f, g, h, i, j], X).
X = [a, b, c, e, f, g, h, i, j]

*/

menos1(_, [], []).

% Caso ElementoAEliminar encontrado.
menos1(ElementoAEliminar, [ElementoAEliminar|ColaListaOriginal], ColaListaOriginal).

% Caso ElementoAElimnar diferente.
menos1(ElementoAEliminar, [ElementoListaOriginal|ColaListaOriginal], [ElementoListaOriginal|ColaListaResultado]):-
    menos1(ElementoAEliminar, ColaListaOriginal, ColaListaResultado).

/*

13) Predicado que relaciona dos átomos A y B, y dos listas C y D, tal que D es igual a C,
pero con el átomo A sustituido por el B, en su primera ocurrencia.
?- sustituida1(d, m, [a, b, c, d, e, f, g, h, i, j], X).
X = [a, b, c, m, e, f, g, h, i, j]

*/

sustituida1(ElementoASustituir, ElementoAInsertar, [ElementoASustituir|ColaListaOriginal], [ElementoAInsertar|ColaListaOriginal]).

sustituida1(ElementoASustituir, ElementoAInsertar, [CabezaListaOriginal|ColaListaOriginal], [CabezaListaOriginal|ColaListaResultado]):-
    sustituida1(ElementoASustituir, ElementoAInsertar, ColaListaOriginal, ColaListaResultado).

/*

14) Predicado que relaciona dos átomos A y B, y dos listas C y D, tal que D es igual a C,
pero con el átomo A sustituido por el B, en todas sus ocurrencias.
?- sustituidan(d, m, [a, b, c, d, e, d, g, h, d, j], X).
X = [a, b, c, m, e, m, g, h, m, j]

*/

sustituidaN(_, _, [], []).

sustituidaN(ElementoASustituir, ElementoAInsertar, [ElementoASustituir|ColaListaOriginal], [ElementoAInsertar|ColaListaResultado]):-
    sustituidaN(ElementoASustituir, ElementoAInsertar, ColaListaOriginal, ColaListaResultado).

sustituidaN(ElementoASustituir, ElementoAInsertar, [CabezaListaOriginal|ColaListaOriginal], [CabezaListaOriginal|ColaListaResultado]):-
    sustituidaN(ElementoASustituir, ElementoAInsertar, ColaListaOriginal, ColaListaResultado).

/*

15) Predicado que vincula un número decimal, la nueva base y la lista formada por los
dígitos que representan el mismo número en la nueva base.
?- enBase(67, 2, L).
L = [1, 0, 0, 0, 1, 1]

*/

convertirABase(Numero, Base, [], ListaFinal):-
    Numero > Base,
    Resto is (Numero mod Base),
    NuevoNumero is (Numero // Base),
    convertirABase(NuevoNumero, Base, [Resto], ListaFinal).

convertirABase(Numero, Base, ListaParcial, ListaFinal):-
    Numero >= Base,
    Resto is (Numero mod Base),
    NuevoNumero is (Numero // Base),
    append([Resto], ListaParcial, NuevaListaParcial),
    convertirABase(NuevoNumero, Base, NuevaListaParcial, ListaFinal).

convertirABase(Numero, _, ListaParcial, ListaFinal):-
    append([Numero], ListaParcial, ListaFinal).

aHexadecimal(10, a).
aHexadecimal(11, b).
aHexadecimal(12, c).
aHexadecimal(13, d).
aHexadecimal(14, e).
aHexadecimal(15, f).

convertirAHexadecimal([Cabeza|Cola], [Caracter|ColaHexadecimal]):-
    aHexadecimal(Cabeza, Caracter),
    convertirAHexadecimal(Cola, ColaHexadecimal).

convertirAHexadecimal([Cabeza|Cola], [Cabeza|ColaHexadecimal]):-
    convertirAHexadecimal(Cola, ColaHexadecimal).

convertirAHexadecimal([], []).

enBase(Numero, Base, Lista):-
    2 =< Base,
    Base =< 15,
    convertirABase(Numero, Base, _, Lista).

enBase(Numero, 16, ListaFinal):-
    convertirABase(Numero, 16, _, ListaParcial),
    convertirAHexadecimal(ListaParcial, ListaFinal).

/*

16) Predicado que relaciona una lista L1 y un número N, con otra lista L2, con los
elementos de L1 menos los primeros N.
?- menosn(4, [a, b, c, d, e, f, g, h, i, j], X).
X = [e, f, g, h, i, j]

*/

menosn(0, Lista, Lista).

menosn(CantidadAEliminar, [_|Cola], ListaResultado):-
    NuevaCantidadAEliminar is CantidadAEliminar - 1,
    menosn(NuevaCantidadAEliminar, Cola, ListaResultado).

/*

17) Predicado que relaciona una lista con su inversa.
?- inversa([a, b, c, d, e, f, g, h, i, j], X).
X = [j, i, h, g, f, e, d, c, b, a]

*/

inversa([], []).

inversa([Elemento|Cola], ListaReversa):-
    inversa(Cola, ListaReversaAuxiliar),
    append(ListaReversaAuxiliar, [Elemento], ListaReversa).

/*

18) Predicado que relaciona un número N y una lista numérica ordenada L1, con otra lista
numérica ordenada L2, formada con los elementos de L1 y el número N.
?- insertado(6, [2, 3, 7, 9, 15], X).
X = [2, 3, 6, 7, 9, 15]

*/

% Caso recursivo donde ElementoAInsertar es mayor a la Cabeza de la lista.
insertado(ElementoAInsertar, [Cabeza|ColaListaOriginal], [Cabeza|ColaListaResultado]):-
    ElementoAInsertar > Cabeza,
    insertado(ElementoAInsertar, ColaListaOriginal, ColaListaResultado).

% Caso base donde ElementoAInsertar es menor a la Cabeza de la lista.
insertado(ElementoAInsertar, [Cabeza|ColaListaOriginal], [ElementoAInsertar, Cabeza|ColaListaOriginal]):-
    ElementoAInsertar < Cabeza.

% Caso base donde ElementoAInsertar es menor a la Cabeza de la lista.
insertado(ElementoAInsertar, [Cabeza], [Cabeza, ElementoAInsertar]).

/*

19) Predicado que relaciona una lista L1 y un número N, menor o igual que la longitud de
L1, con el enésimo elemento de L1.
?- enesimo(4, [a, b, c, d, e, f, g, h, i, j], X).
X = d

*/

enesimo(PosicionElemento, [_|Cola], EnesimoElemento):-
    PosicionElemento > 1,
    NuevaPosicionElemento is PosicionElemento - 1,
    enesimo(NuevaPosicionElemento, Cola, EnesimoElemento).

enesimo(1, [Cabeza|_], Cabeza).

/*

20) Predicado que vincula un número en notación romana, tal que los caracteres romanos
son elementos de una lista L1, con el mismo número en notación arábiga.
?- arabigo([m, c, m, x, c, i, v], X).
X = 1994

*/

aArabigo(m, 1000).
aArabigo(d, 500).
aArabigo(c, 100).
aArabigo(l, 50).
aArabigo(x, 10).
aArabigo(v, 5).
aArabigo(i, 1).

arabigo([], 0).

arabigo([NumeroEnRomano| ColaListaEnRomano], TotalNumeroEnArabigo):-
    arabigo(ColaListaEnRomano, TotalParcial),
    aArabigo(NumeroEnRomano, NumeroEnArabigo),
    TotalNumeroEnArabigo is NumeroEnArabigo + TotalParcial.

/*

21) Predicado que relaciona una lista numérica con el menor de sus elementos.
?- menor([6, 8, 2, 3, 7, 4, 9, 5], X).
X = 2

*/

menor([Elemento|Cola], MenorElemento):-
    buscarMenorElemento(Cola, Elemento, MenorElemento).

buscarMenorElemento([], MenorElementoParcial, MenorElementoParcial).

buscarMenorElemento([Elemento|Cola], MenorElementoParcial, MenorElementoTotal):-
    Elemento < MenorElementoParcial,
    buscarMenorElemento(Cola, Elemento, MenorElementoTotal).

buscarMenorElemento([Elemento|Cola], MenorElementoParcial, MenorElementoTotal):-
    MenorElementoParcial < Elemento,
    buscarMenorElemento(Cola, MenorElementoParcial, MenorElementoTotal).
    
/*

22) Predicado que relaciona una lista numérica L1, con otra L2, con los mismos elementos
que L1, pero con el mayor de ellos en el último lugar.
?- ultimayo([6, 8, 12, 3, 7, 4, 9, 5], X).
X = [6, 8, 3, 7, 4, 9, 5, 12]

*/

esMayor([], MayorElementoParcial, MayorElementoParcial).

esMayor([Elemento|Cola], MayorElementoParcial, MayorElementoFinal):-
    Elemento > MayorElementoParcial,
    esMayor(Cola, Elemento, MayorElementoFinal).

esMayor([Elemento|Cola], MayorElementoParcial, MayorElementoFinal):-
    MayorElementoParcial > Elemento,
    esMayor(Cola, MayorElementoParcial, MayorElementoFinal).

devolverMayor([Elemento|Cola], Mayor):-
    esMayor(Cola, Elemento, Mayor).

borrarElemento(ElementoABorrar, [Elemento|Cola], [Elemento|ColaListaResultado]):-
    ElementoABorrar \= Elemento,
    borrarElemento(ElementoABorrar, Cola, ColaListaResultado).

borrarElemento(ElementoABorrar, [ElementoABorrar|Cola], Cola).

ultimayo(ListaOriginal, ListaResultado):-
    devolverMayor(ListaOriginal, ElementoABorrar),
    borrarElemento(ElementoABorrar, ListaOriginal, ListaBorrada),
    append(ListaBorrada, [ElementoABorrar], ListaResultado).

/*

23) Predicado que relaciona dos vectores de igual dimensión con su producto escalar. Las
coordenadas de cada vector son elementos de una lista.
?- producto([2,1,3],[2,2,1],N).
N = 9

*/

producto([ComponenteUno], [ComponenteDos], (ComponenteUno * ComponenteDos)).

producto([ComponenteUno|ColaVectorUno], [ComponenteDos|ColaVectorDos], ProductoEscalar):-
    SumaDeComponentes is ComponenteUno * ComponenteDos,
    producto(ColaVectorUno, ColaVectorDos, ProductoEscalarParcial),
    ProductoEscalar is SumaDeComponentes + ProductoEscalarParcial.

/*

24) Se necesita saber el puntaje que suma un Pacman en su recorrido hasta llegar a la
terminar el nivel. En su recorrido se puede encontrar con frutas con distinto puntaje y
con el activador del bonus que duplica todos los puntos de las cosas que coma
durante 5 pasos. Escribir un predicado que relacione una lista de objetos que se come
el Pacman con el puntaje obtenido. Para ello usar la siguiente base de hechos.

puntaje(puntito, 1).
puntaje(frutilla, 10).
puntaje(banana, 30).
puntaje(cerezas, 50).
puntaje(fantasma, 100).

?- puntajePacman([puntito, frutilla, puntito, puntito, banana, puntito, puntito,
fantasma, puntito, puntito, cerezas, puntito], Puntos).
Puntos = 198.
?- puntajePacman([puntito, puntito, puntito, banana, puntito, puntito, bonus,
puntito, puntito, fantasma, puntito, puntito, cerezas, puntito], Puntos).
Puntos = 294.

*/

puntaje(puntito, 1).
puntaje(frutilla, 10).
puntaje(banana, 30).
puntaje(cerezas, 50).
puntaje(fantasma, 100).

calcularPuntajePacman([], 0, _).

calcularPuntajePacman([bonus|Cola], PuntajeTotalParcial, CantidadDeBonus):-
    NuevaCantidadDeBonus is CantidadDeBonus + 5,
    calcularPuntajePacman(Cola, PuntajeTotalParcial, NuevaCantidadDeBonus).

calcularPuntajePacman([Elemento|Cola], PuntajeTotal, CantidadDeBonus):-
    CantidadDeBonus =:= 0,
    puntaje(Elemento, PuntajeElemento),
    calcularPuntajePacman(Cola, PuntajeTotalParcial, CantidadDeBonus),
    PuntajeTotal is PuntajeElemento + PuntajeTotalParcial.

calcularPuntajePacman([Elemento|Cola], PuntajeTotal, CantidadDeBonus):-
    CantidadDeBonus > 0,
    NuevaCantidadDeBonus is CantidadDeBonus - 1,
    puntaje(Elemento, PuntajeElemento),
    calcularPuntajePacman(Cola, PuntajeTotalParcial, NuevaCantidadDeBonus),
    PuntajeTotal is (PuntajeElemento * 2) + PuntajeTotalParcial.

puntajePacman(ListaDePuntos, PuntajeTotal):-
    calcularPuntajePacman(ListaDePuntos, PuntajeTotal, 0).

/*

25) Escribir un predicado que relaciona tres listas que representan las 3 filas de un tablero
de TATETI, con el símbolo que gana la partida.
Nota: El símbolo ""v"" representa que la casilla no es de ninguno de los jugadores
porque se ganó el juego antes y quedó vacía.
Nota2: Todas las partidas ingresadas tienen 1 solo ganador. No es necesario controlar
ese aspecto.

?- tateti([x,x,x],[o,x,o],[o,o,v], Ganador).
Ganador = x.
?- tateti([o,x,x],[o,x,o],[o,v,x], Ganador).
Ganador = o.
?- tateti([o,x,o],[v,o,x],[o,x,v], o).
true

*/

simbolo(o).
simbolo(x).

% filas.

tateti([Item, Item, Item], [_, _, _], [_, _, _], Item):-
    simbolo(Item).

tateti([_, _, _], [Item, Item, Item], [_, _, _], Item):-
    simbolo(Item).

tateti([_, _, _], [_, _, _], [Item, Item, Item], Item):-
    simbolo(Item).

% Columnas.

tateti([Item, _, _], [Item, _, _], [Item, _, _], Item):-
    simbolo(Item).

tateti([Item, _, _], [Item, _, _], [Item, _, _], Item):-
    simbolo(Item).

tateti([_, _, Item], [_, _, Item], [_, _, Item], Item):-
    simbolo(Item).

% Oblicuas.

tateti([Item, _, _], [_, Item, _], [_, _, Item], Item):-
    simbolo(Item).

tateti([_, _, Item], [_, Item, _], [Item, _, _], Item):-
    simbolo(Item).

/*

26) Escribir un predicado que relacione una lista con las palabras que forman un número
menor de 1000 escrito en letras con el número en sí.
?- deNombreANumero([ciento, cuarenta, y, dos], N).
N = 142.
?- deNombreANumero([doscientos, dieciseis], N).
N = 216.

*/

toNumero(ciento, 100).
toNumero(doscientos, 200).
toNumero(trescientos, 300).
toNumero(cuatrocientos, 400).
toNumero(quinientos, 500).
toNumero(seiscientos, 600).
toNumero(setecientos, 700).
toNumero(ochocientos, 800).
toNumero(novecientos, 900).

toNumero(diez, 10).
toNumero(once, 11).
toNumero(doce, 12).
toNumero(trece, 13).
toNumero(catorce, 14).
toNumero(quince, 15).
toNumero(dieciseis, 16).
toNumero(diecisiete, 17).
toNumero(dieciocho, 18).
toNumero(diecinueve, 19).

toNumero(veinte, 20).
toNumero(veintiuno, 21).
toNumero(veintidos, 22).
toNumero(veintitres, 23).
toNumero(veinticuatro, 24).
toNumero(veinticinco, 25).
toNumero(veintiseis, 26).
toNumero(veintisiete, 27).
toNumero(veintiocho, 28).
toNumero(veintinueve, 29).

toNumero(treinta, 30).
toNumero(cuarenta, 40).
toNumero(cincuenta, 50).
toNumero(sesenta, 60).
toNumero(setenta, 70).
toNumero(ochenta, 80).
toNumero(noventa, 90).

toNumero(cero, 0).
toNumero(uno, 1).
toNumero(dos, 2).
toNumero(tres, 3).
toNumero(cuatro, 4).
toNumero(cinco, 5).
toNumero(seis, 6).
toNumero(siete, 7).
toNumero(ocho, 8).
toNumero(nueve, 9).

toNumero(y, 0).

deNombreANumero([], 0).

deNombreANumero([Elemento|Cola], Numero):-
    toNumero(Elemento, NumeroASumar),
    deNombreANumero(Cola, TotalParcial),
    Numero is NumeroASumar + TotalParcial.

/*

Listas Multinivel.

*/

/*

27) Predicado que relaciona dos listas de igual longitud L1 y L2, con una tercera L3, tal que
los elementos de L3 son sublistas formadas por los elementos correspondientes de L1
y L2 tomados de a pares.
?- duplas([d, a, b], [m, k, f], X).
X = [[d, m], [a, k], [b, f]]

*/

duplas([], [], []).

duplas([ElementoListaUno|ColaListaUno], [ElementoListaDos|ColaListaDos], [[ElementoListaUno, ElementoListaDos]|ColaListaConDuplas]):-
    duplas(ColaListaUno, ColaListaDos, ColaListaConDuplas).

/*

28) Predicado que relaciona una lista con la cantidad de átomos que contiene.
?- atomos([a,b,[c,d],[e],[f,[g,h]]],N).
N = 8

*/

atomos([], 0).

atomos([Elemento|Cola], CantidadDeAtomos):-
    atom(Elemento),
    atomos(Cola, CantidadDeAtomosParcial),
    CantidadDeAtomos is CantidadDeAtomosParcial + 1.

atomos([Elemento|Cola], CantidadDeAtomos):-
    atomos(Elemento, CantidadDeAtomosCabeza),
    atomos(Cola, CantidadDeAtomosCola),
    CantidadDeAtomos is CantidadDeAtomosCabeza + CantidadDeAtomosCola.

/*

29) Predicado que relaciona una lista de listas, con otra lista formada únicamente con los
átomos de la primera.
?- planchada([a,[b,[c,d,[e]],f],g,h],L).
L=[a,b,c,d,e,f,g,h]

*/

planchada([], []).

planchada([Elemento|ColaListaOriginal], [Elemento|ColaListaPlanchada]):-
    atom(Elemento),
    planchada(ColaListaOriginal, ColaListaPlanchada).

planchada([Elemento|ColaListaCabeza], ColaListaPlanchada):-
    planchada(Elemento, ColaListaPlanchadaCabeza),
    planchada(ColaListaCabeza, ColaListaPlanchadaCola),
    append(ColaListaPlanchadaCabeza, ColaListaPlanchadaCola, ColaListaPlanchada).

/*

31)Predicado que relaciona una lista numérica, un número N y una lista
conteniendo dos sublistas, una con los elementos menores que N y otra con los
mayores a N.
?- separaMayMen( [1, 8, 3, 4, 5, 2, 7], 4, L)
L = [[1, 3, 2], [8, 5, 7]]

*/

separaMayMen([], _, [[], []]).

separaMayMen([Numero|ColaDeNumeros], NumeroFrontera, [[Numero|ColaMenores], ListaMayores]):-
    Numero < NumeroFrontera,
    separaMayMen(ColaDeNumeros, NumeroFrontera, [ColaMenores, ListaMayores]).

separaMayMen([Numero|ColaDeNumeros], NumeroFrontera, [ListaMenores, [Numero|ColaMayores]]):-
    Numero >= NumeroFrontera,
    separaMayMen(ColaDeNumeros, NumeroFrontera, [ListaMenores, ColaMayores]).

/*

35) Escribir un predicado que relacione a una lista multinivel con el nivel más profundo en
el que se encuentre un elemento dado
% nivelMasProfundo(Elemento, ListaM, Nivel).
?- nivelMasProfundo(a, [a, b, [c, d, [e, [f], [g, a]]]], Nivel)
Nivel = 4

*/

maximo(NumeroUno, NumeroUno, NumeroUno).

maximo(NumeroUno, NumeroDos, NumeroUno):-
    NumeroUno > NumeroDos.

maximo(_, NumeroDos, NumeroDos).

auxiliarNivel(Elemento, [Cabeza|Cola], NivelActual, NivelMaximo, Resultado):-
    is_list(Cabeza),
    NuevoNivelActual is NivelActual + 1,
    auxiliarNivel(Elemento, Cabeza, NuevoNivelActual, NivelMaximo, NuevoResultadoCabeza),
    auxiliarNivel(Elemento, Cola, NivelActual, NivelMaximo, NuevoResultadoCola),
    maximo(NuevoResultadoCabeza, NuevoResultadoCola, MayorResultado),
    Resultado is MayorResultado.

auxiliarNivel(Elemento, [Cabeza|Cola], NivelActual, NivelMaximo, Resultado):-
    atom(Cabeza),
    Elemento \= Cabeza,
    auxiliarNivel(Elemento, Cola, NivelActual, NivelMaximo, NuevoResultado),
    Resultado is NuevoResultado.

auxiliarNivel(Elemento, [Elemento|Cola], NivelActual, NivelMaximo, Resultado):-
    NivelActual > NivelMaximo,
    auxiliarNivel(Elemento, Cola, NivelActual, NivelActual, NuevoResultado),
    Resultado is NuevoResultado.

auxiliarNivel(Elemento, [Elemento|Cola], NivelActual, NivelMaximo, Resultado):-
    auxiliarNivel(Elemento, Cola, NivelActual, NivelMaximo, NuevoResultado),
    Resultado is NuevoResultado.

auxiliarNivel(_, [], _, NivelMaximo, NivelMaximo).

nivelMasProfundo(Elemento, Lista, Nivel):-
    auxiliarNivel(Elemento, Lista, 1, 1, Resultado),
    Nivel is Resultado.

/*

33) Escribir un predicado que relacione una lista de gustos de helado con una lista
formada por todas las combinaciones que se pueden hacer para vender helados de 2
gustos. Realizar las 2 posibilidades. Una que permita repeticiones y otra que no los
permita.

?- heladosPosiblesSinRepeticion([frutilla, chocolate, americana, dulceDeLeche],
Lista).
Lista = [[frutilla, chocolate], [frutilla, americana], [frutilla, dulceDeLeche],
[chocolate, americana], [chocolate, dulceDeLeche], [americana,
dulceDeLeche]].

*/

combinar(Elemento, [Sabor|Cola], ListaParcial, ListaFinal):-
    append(ListaParcial, [[Elemento, Sabor]], NuevaListaParcial),
    combinar(Elemento, Cola, NuevaListaParcial, ListaFinal).

combinar(_, [], ListaParcial, ListaParcial).

verCombinaciones([Sabor|ColaSabores], ListaCombinacionesParcial, ListaCombinacionesFinal):-
    combinar(Sabor, ColaSabores, _, NuevaListaCombinaciones),
    append(ListaCombinacionesParcial, NuevaListaCombinaciones, NuevaListaCombinacionesParcial),
    verCombinaciones(ColaSabores, NuevaListaCombinacionesParcial, ListaCombinacionesFinal).

verCombinaciones([_], ListaCombinacionesParcial, ListaCombinacionesParcial).

heladosPosiblesSinRepeticion(ListaSabores, ListaCombinaciones):-
    verCombinaciones(ListaSabores, _, ListaCombinaciones).

/*

?- heladosPosiblesConRepeticion([frutilla,chocolate, americana, dulceDeLeche],
Lista).
Lista = [[frutilla, frutilla],[frutilla, chocolate], [frutilla, americana], [frutilla,
dulceDeLeche], [chocolate, chocolate], [chocolate, americana],
[chocolate, dulceDeLeche], [americana, americana], [americana,
dulceDeLeche]].

*/

combinarConRepeticion(_, [Sabor|ColaSabores], [], ListaFinal):-
    combinarConRepeticion(Sabor, ColaSabores, [[Sabor, Sabor]], ListaFinal).

combinarConRepeticion(Elemento, [Sabor|ColaSabores], ListaParcial, ListaFinal):-
    append(ListaParcial, [[Elemento, Sabor]], NuevaListaParcial),
    combinarConRepeticion(Elemento, ColaSabores, NuevaListaParcial, ListaFinal).

combinarConRepeticion(_, [], ListaParcial, ListaParcial).

verCombinacionesConRepeticion([Sabor|ColaSabores], ListaCombinacionesParcial, ListaCombinacionesFinal):-
    combinarConRepeticion(_, [Sabor|ColaSabores], _, NuevaListaCombinaciones),
    append(ListaCombinacionesParcial, NuevaListaCombinaciones, NuevaListaParcial),
    verCombinacionesConRepeticion(ColaSabores, NuevaListaParcial, ListaCombinacionesFinal).

verCombinacionesConRepeticion([], ListaCombinacionesParcial, ListaCombinacionesParcial).

heladosPosiblesConRepeticion(ListaSabores, ListaCombinaciones):-
    verCombinacionesConRepeticion(ListaSabores, _, ListaCombinaciones).

/*

34) Escribir una función que dada una lista de temperaturas en distintas ciudades del país
retorne una lista de pares ordenados que relacione la cantidad de ciudades que
cumplen con cada una de las clasificaciones. A saber:
a) Helado: Hasta 0º
b) Frio: Más de 0º y menos de 10º
c) Templado: Más de 10º y hasta 25º
d) Cálido: Más de 25º
?- clasifica [-1, 14, 20, 30, -1, -5, 2, 0, 31, 25], Lista).
Lista = [[helado, 4], [frio, 1], [templado, 3], [calido, 2]]

*/

temperatura(helado, -100, 0).
temperatura(frio, 1, 10).
temperatura(templado, 11, 25).
temperatura(calido, 26, 100).

clasificar([Temperatura|Cola], Clima, Cantidad):-
    temperatura(Clima, Minima, Maxima),
    Minima =< Temperatura,
    Temperatura =< Maxima,
    clasificar(Cola, Clima, NuevaCantidad),
    Cantidad is NuevaCantidad + 1.

clasificar([_|Cola], Clima, Cantidad):-
    clasificar(Cola, Clima, Cantidad).

clasificar([], _, 0).

clasifica(ListaTemperaturas, [[helado, CantidadHelado], [frio, CantidadFrio], [templado, CantidadTemplado], [calido, CantidadCalido]]):-
    clasificar(ListaTemperaturas, helado, CantidadHelado),
    clasificar(ListaTemperaturas, frio, CantidadFrio),
    clasificar(ListaTemperaturas, templado, CantidadTemplado),
    clasificar(ListaTemperaturas, calido, CantidadCalido).

/*

36) Dada una lista multinivel que representa el árbol genealógico de una familia donde el
primer elemento de cada lista es el nombre del padre y el segundo elemento es una
lista con sus hijos, pero si estos tienen hijos se presentarán con una lista con la misma
estructura. De esta manera las personas que no tienen hijos se representan con una
lista solo con su nombre, ya que la cola vacía representa que no tiene hijos.
Escribir un predicado relacione a una persona con la lista de todos sus antecesores.

% antecesores(Persona, ArbolGenealogico, Lista)
?- antecesores(pedro, [juan, [carlos, [roberto, [pedro], [pablo]]], [jose, [mario, [aldo]]], [raul]], Lista).
Lista= [juan, carlos, roberto]

*/

listaAntecesores([juan, [carlos, [roberto, [pedro], [pablo]]], [jose, [mario, [aldo]]], [raul]]).

listaCargarda([_|_]).

auxiliarAntecesores(Persona, [Cabeza|_], ListaParcial, ListaAntecesores):-
    is_list(Cabeza),
    auxiliarAntecesores(Persona, Cabeza, _, ListaAntecesoresCabeza),
    listaCargarda(ListaAntecesoresCabeza),
    append(ListaParcial, ListaAntecesoresCabeza, ListaAntecesores).

auxiliarAntecesores(Persona, [Cabeza|ColaArbolGenealogico], ListaParcial, ListaAntecesores):-
    is_list(Cabeza),
    auxiliarAntecesores(Persona, ColaArbolGenealogico, _, ListaAntecesoresCola),
    listaCargarda(ListaAntecesoresCola),
    append(ListaParcial, ListaAntecesoresCola, ListaAntecesores).

auxiliarAntecesores(_, [Cabeza|_], [_], []):-
    is_list(Cabeza).

auxiliarAntecesores(Persona, [Cabeza|ColaArbolGenealogico], ListaParcial, ListaAntecesores):-
    atom(Cabeza),
    Persona \= Cabeza,
    append(ListaParcial, [Cabeza], NuevaListaParcial),
    auxiliarAntecesores(Persona, ColaArbolGenealogico, NuevaListaParcial, ListaAntecesores).

auxiliarAntecesores(Persona, [Persona|_], [], []).

auxiliarAntecesores(Persona, [Persona|_], ListaParcial, ListaParcial).

auxiliarAntecesores(_, [], _, []).

antecesores(Persona, ArbolGenealogico, ListaAntecesores):-
    auxiliarAntecesores(Persona, ArbolGenealogico, _, ListaAntecesores).

/*

37) Escribir un predicado que dadas dos listas ordenadas correspondientes a las tiradas
de dados de 2 jugadores unifique un tercer argumento con el nombre del jugador gana
a la GeneralaPFyL.

Las reglas de la generalaPFyL son:
Generala: cuando se logran los cinco dados con un mismo número y vale 60
puntos. Ej: [1, 1, 1, 1, 1]
Poker: cuatro de un mismo número. Vale 40 puntos.
Ej: [1, 1, 1, 1, 2] o [2, 3, 3, 3, 3]
Full: tres de un mismo número y un par. Vale 30 puntos.
Ej: [1, 1, 1, 2, 2] o [3, 3, 5, 5, 5]
Escalera: Los dados del 1 al 5 o del 2 al 6. Vale 20 puntos.
Ej: [1, 2, 3, 4, 5] o [2, 3, 4, 5, 6]

En caso de no completar ninguna de las opciones anteriores el puntaje
obtenido es el valor mayor entre la suma de los dados que tiene valores que
se repiten o el mayor de los valores de los dados.
[1, 1, 2, 2, 6] -> El puntaje obtenido es 6 porque es mayor que 1 + 1 y que
2 + 2
[1, 1, 4, 4, 6] -> El puntaje obtenido es 8 porque 4 + 4 es mayor que 6.
?- generalaPFyL([carlos, [2, 2, 2, 2, 2]], [pedro, [2, 3, 4, 5, 6]], Ganador).
Ganador = carlos
?- generalaPFyL([carlos, [1, 1, 2, 2, 6]], [pedro, [2, 2, 4, 5, 6]], Ganador).
Ganador = empate

*/

valoresDados([Valor, Valor, Valor, Valor, Valor], 60).

valoresDados([Valor, Valor, Valor, Valor, _], 40).
valoresDados([_, OtroValor, OtroValor, OtroValor, OtroValor], 40).

valoresDados([Valor, Valor, Valor, OtroValor, OtroValor], 30).
valoresDados([Valor, Valor, OtroValor, OtroValor, OtroValor], 30).

valoresDados([1, 2, 3, 4, 5], 20).
valoresDados([2, 3, 4, 5, 6], 20).

mayorSuma([Valor|Cola], Valor, SumaActual, UltimaSuma, Resultado):-
    NuevaSumaActual is SumaActual + Valor,
    mayorSuma(Cola, Valor, NuevaSumaActual, UltimaSuma, Resultado).

mayorSuma([Valor|Cola], UltimoValor, SumaActual, UltimaSuma, Resultado):-
    Valor \= UltimoValor,
    SumaActual > UltimaSuma,
    mayorSuma(Cola, Valor, Valor, SumaActual, Resultado).

mayorSuma([Valor|Cola], UltimoValor, _, UltimaSuma, Resultado):-
    Valor \= UltimoValor,
    mayorSuma(Cola, Valor, Valor, UltimaSuma, Resultado).

mayorSuma([], _, SumaActual, UltimaSuma, SumaActual):-
    SumaActual > UltimaSuma.

mayorSuma([], _, _, UltimaSuma, UltimaSuma).

calcularPuntaje(NombreJugador, ValoresDados, [NombreJugador, Puntaje]):-
    valoresDados(ValoresDados, Puntaje).

calcularPuntaje(NombreJugador, [Valor|Cola], [NombreJugador, Puntaje]):-
    mayorSuma(Cola, Valor, Valor, 0, Puntaje).

maximoPuntaje([NombreJugadorUno, ValoresDadosUno], [_, ValoresDadosDos], NombreJugadorUno):-
    ValoresDadosUno >= ValoresDadosDos.

maximoPuntaje([_, _], [NombreJugadorDos, _], NombreJugadorDos).

generalaPFyL([NombreJugadorUno, ValoresDadosUno], [NombreJugadorDos, ValoresDadosDos], Ganador):-
    calcularPuntaje(NombreJugadorUno, ValoresDadosUno, PuntajeJugadorUno),
    calcularPuntaje(NombreJugadorDos, ValoresDadosDos, PuntajeJugadorDos),
    maximoPuntaje(PuntajeJugadorUno, PuntajeJugadorDos, Ganador).
