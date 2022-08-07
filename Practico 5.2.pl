
/*

 PRACTICO 5

*/

/* 

Introducción a la recursividad en Prolog 

*/

/*

39) El factorial
Definición recursiva
      | 1 si N = 0
 N! = |
      | N*(N-1)! de otro modo

*/

factorial(0, 1).

factorial(Numero, Factorial):-
    NuevoNumero is Numero - 1,
    factorial(NuevoNumero, FactorialParcial),
    Factorial is FactorialParcial * Numero.

/*

40) Potencia con exponente natural: Escribir la regla de un predicado que vincule un
número base y otro exponente con la correspondiente potencia.

*/

potencia(0, _, 1).

potencia(1, _, 1).

potencia(Numero, 1, Numero).

potencia(Numero, Exponente, Potencia):-
    NuevoExponente is Exponente - 1,
    potencia(Numero, NuevoExponente, PotenciaParcial),
    Potencia is PotenciaParcial * Numero.

/*

41) Otra forma de calcular recursivamente la potencia con exponente natural más
eficientemente es usando la siguiente función:\

      | 1 si n es cero
      |
m^n = | (m^2)^(n/2) si n es par
      |
      | m*(m^2)^((n-1)/2) si n es impar

Podemos probar esta función con un caso, por ejemplo 2^8, para mostrar que
efectivamente computa m^n.

2^8 = (2*2)^(8/2) = 4^4 = (4*4)^(4/2) = 16^2 = (16*16)^1 = 256^1 =
256*(256*256)^((1-1)/2) = 256 * (256*256)^0 = 256 * 1 = 256

*/

potencia(_, 0, 1).

potencia(NumeroBase, Exponente, Potencia):-
	mod(Exponente, 2) =:= 0,
	NuevoNumeroBase is NumeroBase ^ 2,
	NuevoExponente is Exponente / 2,
	potencia(NuevoNumeroBase, NuevoExponente, Potencia).

potencia(NumeroBase, Exponente, Potencia):-
	NuevoNumeroBase is NumeroBase ^ 2,
	NuevoExponente is (Exponente - 1) /2,
	potencia(NuevoNumeroBase, NuevoExponente, PotenciaParcial),
	Potencia is NumeroBase * PotenciaParcial.

/*

42) La sucesión de Leonardo de Pisa (Fibonacci) Resolver el problema de encontrar el
enésimo término de la sucesión de Fibonacci.
 
*/

fibonacci(0, 0).

fibonacci(1, 1).

fibonacci(Numero, Resultado):-
    NumeroUno is Numero - 1,
    NumeroDos is Numero - 2,
    fibonacci(NumeroUno, ResultadoUno),
    fibonacci(NumeroDos, ResultadoDos),
    Resultado is ResultadoUno + ResultadoDos.

/*

43) Definir un predicado recursivo que sea verdadero cuando su argumento es un número
primo.

*/

verSiEsPrimo(_, 1).

verSiEsPrimo(Numero, Divisor):-
    mod(Numero, Divisor) =\= 0,
    NuevoDivisor is Divisor - 1,
    verSiEsPrimo(Numero, NuevoDivisor).

esPrimo(Numero):-
    Divisor is Numero - 1,
    verSiEsPrimo(Numero, Divisor).
    
/*

44) Resolver el problema de encontrar el MCD entre dos números, sabiendo que, si los
números son iguales, el MCD es el mismo número, en otro caso el MCD es igual al
MCD entre el menor de ellos y la diferencia entre ambos.

*/

% Caso iguales.
maximoComunDivisor(NumeroUno, NumeroUno, NumeroUno).

% Caso NumeroUno menor.
maximoComunDivisor(NumeroUno, NumeroDos, MCD):-
    NumeroUno < NumeroDos,
    Diferencia is (NumeroDos - NumeroUno), 
    maximoComunDivisor(NumeroUno, Diferencia, MCDAux),
    MCD is MCDAux.

% Caso NumeroDos menor.
maximoComunDivisor(NumeroUno, NumeroDos, MCD):-
    Diferencia is (NumeroUno - NumeroDos), 
    maximoComunDivisor(NumeroDos, Diferencia, MCDAux),
    MCD is MCDAux.


/*

Ejercicios de evaluaciones pasadas

*/

/*

45) Un número es divisible por 7 cuando separando la primera cifra de la derecha,
multiplicándola por 2, restando este producto de lo que queda a la izquierda y así
sucesivamente, da cero o múltiplo de 7.

Por ejemplo, los siguientes números son divisibles entre 7, porque:3
32291 última cifra 1 -> 1x2=2
3229-2 = 3227 última cifra 7 -> 7x2=14
322-14 = 308 última cifra 8 -> 8x2=16
30-16 = 14 resultado parcial 14.
Como 14 pertenece a la tabla del 7 (7x1 … 7x10) el número original es divisible
por 7.
Generar un algoritmo que decida si un número dado es múltiplo de 7 o no,
utilizando este método

*/

%Caso si es 0.
esDivisiblePor7(0).

% Caso si es multiplo de 7.
esDivisiblePor7(Numero):-
    Numero mod 7 =:= 0.

% Caso si no es multiplo de 7.
esDivisiblePor7(Numero):-
    Numero > 7,
    Resto is (Numero mod 10),
    NuevoNumero is Numero // 10,
    TotalParcial is NuevoNumero - (Resto * 2),
    esDivisiblePor7(TotalParcial).
