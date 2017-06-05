%Extensao do predicado soma: valor1, valor2,soma ->{V,F}

soma(A,B,C) :-
	C is A+B.

% Extensão do predicado aplicar: valor1, valor2, operação, resultado -> {V,F}

aplicar(A,B,"soma",R) :-
	soma(A,B,R).

aplicar(A,B,"sub",R) :-
	R is A-B.

aplicar(A,B,"mult",R) :- 
	R is A*B.

aplicar(A,B,"div",R) :- 
	B \= 0, 
	R is A/B.

%Extensão do predicado soma3 :valor1,valor2,valor3,resultado -> {V,F}

soma3(A,B,C,R) :-
	R is A+B+C.

%Extensão do predicado somaLista: lista, resultado -> {V,F}

somaLista([H],R) :-
	R is H.
somaLista([H|T],R) :-
	somaLista(T,L),
	R is H+L.

%Extensão do predicado aplicarLista: Lista, operação,resultado -> {V,F}

aplicarLista(H,"soma",R) :-
	somaLista(H,R).

aplicarLista([H],"sub",R) :-
	R is H.
aplicarLista([H|T],"sub",R) :-
	aplicarLista(T,"sub",L),
	R is H-L.

aplicarLista([H],"mult",R) :-
	R is H.
aplicarLista([H|T],"mult",R) :-
	aplicarLista(T,"mult",L),
	R is H*L.



aplicarLista([H],"inv",R) :-
	inverso(H,L),
	R = [L].

aplicarLista([H|T],"inv",R) :-
	aplicar(T,"inv",L),
	inverso(H,S),
	R = [S|L].

%Extensao do predicado inverso: valor, inverso -> {V,F}
inverso(H,R) :-
	H \=0,
	R is 1/H.

%Extensao do predicado maior:valor, valor, resposta -> {V,F}
maior(A,B,R) :-
	A>B,
	R is A.
maior(A,B,R) :-
	A<=B,
	R is B.


%Extensao do predicado maiorLista: Lista, Resposta -> {V,F}

maiorLista([H],R):-
	R is H.
maiorLista([X|L],R) :- 
	maiorLista(L,N),
	X>N,
	R is X.
maiorLista([X|L],R) :- 
	maiorLista(L,N),
	X=<N,
	R is N.

%Extensao do predicado menor: valor, valor, resposta -> {V,F}
menor(A,B,A) :-
	A<B.

maior(A,B,R) :-
	A=<B,
	R is B.


%Extensao do predicado menorLista: Lista, Resposta -> {V,F}

menorLista([H],R):-
	R is H.
menorLista([X|L],R) :- 
	menorLista(L,N),
	X<N,
	R is X.
menorLista([X|L],R) :- 
	menorLista(L,N),
	X>=N,
	R is N.

%Extensão do predicado comprimento: Lista, Resultado -> {V,F}

comprimento([],0).
comprimento([H|T],R):-
	comprimento(T,S),
	R is 1+S.

%Extensão do predicado media: Lista, Resultado -> {V,F}

media([],0).
media([H|T],R):-
	comprimento([H|T],C),
	somaLista([H|T],S),
	aplicar(S,C,"div",R).

%Extensão do predicado ordena: Lista,Resultado -> {V,F}

ordena([H],[H]).
ordena([H|T],R) :-
	ordena(T,L),
	insere(H,L,R).


%Extensão do predicado insere: Valor, Lista, ListaResultado ->{V,F}

insere(X,[],[X]).
insere(X,[H|T],[X,H|T]):-
	X=<H.
insere(X,[H|T],[H|XS]) :-
	X>H,
	insere(X,T,XS).

%Extensao do predicado vazios: Lista de listas, Resultado -> {V,F}

vazios([],0).
vazios([H|T],R):-
	vazios(T,S),
	H = [],
	R is S+1.
vazios([H|T],R):-
	vazios(T,S),
	H \= [],
	R is S.


-----------Questões-------------

ficha2(xiv,R) :- soma(1,3,R).				%R = 4.
ficha2(xv,R) :- soma3(1,3,5,R).				%R = 9.
ficha2(xvi,R) :- aplicar(2,4,"mult",R).		%R = 8.
ficha2(xvii,R) :- somaLista([5,3,1],R).		%R = 9.
ficha2(xviii,R) :- maior(1,3,R).			%R = 3.
ficha2(xix,R) :- maior(3,1,R).				%R = 3.
ficha2(xx) :- maior(3,1,S),menor(S,2,S).	%false.
ficha2(xxi,R) :- maiorLista([5,3,7],R).		%R = 7.
ficha2(xxii,R) :- menorLista([2,4,6],R).	%R = 2.
