%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Negacao por falha na prova.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%Extensao do predicado maior: valor1, valor2, maior -> {V,F}
maior(A,B,A):-
	A>B.
maior(A,B,B):-
	B>=A.

%Extensão do predicado pertence: Elemento, Lista -> {V,F}.

pertence(X,[X|T]).
pertence(X,[H|T]) :-
	pertence(X,T).

%Extensão do predicado comprimento: Lista, comp -> {V,F}

comprimento([],0).
comprimento([H|T],R).
	comprimento(T,S),
	R is S+1.

%Extensão do predicado quantos: Lista, resultado -> {V,F}

quantos([],0).
quantos([H|T],R) :-
	quantos(T,L),
	pertence(H,T),
	R is L.
quantos([H|T],R) :-
	quantos(T,L),
	nao(pertence(H,T)),
	R is L+1.

%Extensão do predicado apagar: Elemento, Lista, ListaResultante -> {V,F}

apagar(X,[],[]).
apagar(X,[X|T],T).
apagar(X,[H|T],[H|R]):-
	apagar(X,T,R).

%Extensão do predicado apagarTudo: Elemento, Lista, ListaResultante -> {V,F}

apagarTudo(X,[],[]).
apagarTudo(X,[X|T],R):-
    apagarTudo(X,T,R).
apagarTudo(X,[H|T],[H|R]):-
    X\=H,
    apagarTudo(X,T,R).

%Extensão do predicado adicionar: Elemento, Lista,ListaResultante -> {V,F}

adicionar(X,[],[X]).
adicionar(X,L,R) :-
	nao(pertence(X,L)),
	R = [X|L].
adicionar(X,L,L):-
	pertence(X,L).

%Extensão do predicado concatenar: Lista1,Lista2,ListaResultante->{V,F}

concatenar([],X,X).
concatenar(X,[],X).
concatenar([],[],[]).
concatenar([X|XS],[Y|YS],[X|R]):-
	concatenar(XS,[Y|YS],R).

%Extensão do predicado inverter: Lista, ListaResultante -> {V,F}

inverter([],[]).
inverter([H],[H]).
inverter([H|T],R):-
	inverter(T,L),
	concatenar(L,[X],R).

%Extensão do predicado sublista: Sublista,Lista -> {V,F}
%quando encontra um valor igual, todos os outros têm de tar seguidos

sublista([],L).
sublista([H|T],[H|XS]) :-
	seguido(T,XS).
sublista([H|T],[X|XS]):-
	sublista([H|T],XS).

seguido([], _).
seguido([X | Xs], [X | Ys]) :- 
	seguido(Xs, Ys).

-----------Questoes--------
:- consult('ficha2.pl').
:- consult('ficha1.pl').

ficha3(xiii,R) :- maior(1,3,R).							%R=3.
ficha3(xiv,R) :- maior(3,1,R).							%R=3.
ficha3(xv) :- maior(3,1,S),menor(S,2,S).				%false.
ficha3(xvi) :- nao(filho("Joao","Manuel")).				%true.
ficha3(xvii) :- nao(filho("Joao","Jose")).				%false.
ficha3(xviii):- nao(descendente("Joao","Jose")).		%false.
ficha3(xix) :- nao(descendenteGrau("Joao","Jose",1)).	%false.
ficha3(xx):- pertence('b',['a','b','c']).				%true.
ficha3(xxi) :- pertence(1,['a','b','c']).				%false.
ficha3(xxii):- pertence(X, ['a', 'b', 'c']), X == 'b'.	%true.
ficha3(xxiii,R) :- comprimento([],R).					%R=0.
ficha3(xxiv,R) :- apagar(2,['a','b','c'],R).			%R=[a,b,c].
ficha3(xxv,R) :- apagarTudo(2,['a','b','c'],R).			%R=[a,b,c].
ficha3(xxvi) :- concatenar([1,2],[a,b,c],[1,2,a,b,c]).	%true.
ficha3(xxvii):- sublista([2,3],[1,2,3,4,5]).			%true.
ficha3(xxviii):- sublista([3,2],[1,2,3,4,5]).			%false.
ficha3(xxix):- sublista([2,4],[1,2,3,4,5]).				%false.
ficha3(xxx):- filho(_,"Jose").							%true.
ficha3(xxxi) :- ?
ficha3(xxxii) :- ?
ficha3(xxxiii) :- ?
ficha3(xxxiv) :- ?
ficha3(xxxv) :- ?
ficha3(xxxvi) :- pai("Joao",_).							%false.
