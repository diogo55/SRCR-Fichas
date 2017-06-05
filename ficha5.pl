% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%Extensão do predicado par: numero -> {V,F}

par(N):-
	0 is mod(N,2).

%Extensão do predicado impar: numero -> {V,F}

impar(N) :-
	1 is mod(N,2).

%Extensao do predicado conjuntoNaturais: Lista -> {V,F}

conjuntoNaturais([]).
conjuntoNaturais([H|L]) :-
	integer(H),
	H>0,
	conjuntoNaturais(L).

%Extensão do predicado conjuntoInteiros: Lista -> {V,F}

conjuntoInteiros([]).
conjuntoInteiros([H|T]) :-
	integer(H),
	conjuntoInteiros(T).

%Extensão do predicado arcoIris: Cor -> {V,F}

arcoIris("vermelho").
arcoIris("laranja").
arcoIris("amarelo").
arcoIris("verde").
arcoIris("azul").
arcoIris("anil").
arcoIris("violeta").

%Extensão do predicado atravessar: ... -> {V,F}

atravessar(estrada):-
	nao(carroProximo).

atravessar(caminhodeferro) :-
	nao(comboioProximo).

%????

%Extensão do predicado nodo

nodo(a).
nodo(b).
nodo(c).
nodo(d).
nodo(e).
nodo(f).
nodo(g).

%Extensao do predicado arco: Entrada, Saida -> {V,F}

%arco(X,Y):-
%	nodo(X),
%	nodo(Y).
%terminal nao funciona com isto, por causa do valor do Y suponho.

arco(b,a).
arco(b,a).
arco(c,a).
arco(c,d).
arco(f,g).


%Extensão do predicado terminal: Nodo -> {V,F}

-terminal(X):-
	nodo(X),
	arco(X,Y).

terminal(X) :-
	nodo(X),
	arco(Y,X),
	nao(-terminal(X)).



% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.