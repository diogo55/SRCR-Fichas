%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%Extensão do predicado voo 

voo(X) :- ave(X), nao(excepcao(voo(X))).
-voo(X):- ave(X), excepcao(voo(X)).
-voo(X) :- mamifero(X), nao(excepcao(-voo(X))).
voo(X):- mamifero(X), excepcao(-voo(X)).

-voo(tweety).

%Extensão do predicado ave: animal -> {V,F}


ave(X):-
	canario(X).
ave(X):-
	periquito(X).
ave(X):-
	avestruz(X).
ave(X):-
	pinguim(X).

ave(pitigui).

%Extensão do predicado mamifero: animal -> {V,F}


mamifero(X):-
	cao(X).
mamifero(X):-
	gato(X).
mamifero(X):-
	morcego(X).


mamifero(silvestre).

%Extensão do predicado canario: animal ->{V,F}
canario(piupiu).

%Extensão do predicado cao: animal -> {V,F}

cao(boby).

%Extensão do predicado avestruz: animal -> {V,F}

avestruz(trux).

%Extensão do predicado pinguim: animal -> {V,F}

pinguim(pingu).

%Extensão do predicado morcego: animal -> {V,F}

morcego(batemene).

%-----------------Excepcões------------------
excepcao(voo(X)) :- avestruz(X).
excepcao(voo(X)) :- pinguim(X).
excepcao(-voo(X)) :- morcego(X).