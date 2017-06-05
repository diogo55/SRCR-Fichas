%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

:- consult('ficha1.pl').

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N == 1
                  ).

+pai( F,P ) :: ( solucoes((P,F),(pai(P,F)),S),
				 comprimento(S,N),
				 N==1
                  ).

+neto(N,A) :: (solucoes((N,A),neto(N,A),S),
				comprimento(S,N),
				N==1).

+avo(A,N) :: (solucoes((A,N),avo(A,N),S),
				comprimento(S,N),
				N==1).

+descendenteGrau(D,A,G) :: (solucoes((D,A),descendent(D,A,G),S),
							comprimento(S,N),
							N==1).

% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo


+filho( F,P ) :: (solucoes( (Ps),(filho( F,Ps )),S ),
                  comprimento( S,N ), 
				  N =< 2).

+pai( F,P ) :: (solucoes((Ps),(pai( Ps,F)),S ),
                comprimento( S,N ), 
				N =< 2).

% Invariante Referencial: nao admitir mais do que 4 avos
%                         para um mesmo individuo

+neto(N,A) :: (solucoes((As),neto(N,As),S),
			   comprimento(S,C),
			   C =< 4).

+avo(A,N) :: (solucoes((As),(avo(As,N)),S),
			  comprimento(S,C),
			  C =< 4 ).


+descendenteGrau(D,A,G) :: (integer(G)), G>0.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

comprimento([], 0) .
comprimento([H|T], R) :-
	comprimento(T, X),	R is 1+X .


solucoes(X,Y,Z) :- findall(X,Y,Z).

evolucao( Termo ) :- solucoes(I,+F::I,L), 
					insercao(F), 
					testar(L).

insercao( T ) :- assert(T).
insercao( T ) :- retract(T), !,fail.

testar([]).
testar([I|L]) :- I , testar(L).


