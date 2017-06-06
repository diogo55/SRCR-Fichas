:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').
:- dynamic '-'/1.

nao(Q) :- Q,!,fail.
nao(Q).


demo(Q,verdadeiro) :- Q.
demo(Q,falso) :- -Q.
demo(Q,desconhecido) :- nao(Q), nao(-Q).

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).


%Valores Nulos:
%	- Incerto   I 
%	- Impreciso II 
%	- Interdito III

%--------------------------------------------------------------

%jogo: Identificador do jogo, Árbitro, Ajudas de Custo -> { V,F,D }

jogo(1,aa,500).
jogo(2,bb,xpto1).

excepçao(jogo(I,N,C)):-
	jogo(I,N,xpto1).

excepçao(jogo(3,cc,500)).
excepçao(jogo(3,cc,2500)).

excepçao(jogo(4,dd,C)) :-
	C>=250,
	C=<750.

jogo(5,ee,interdito).
nulo(interdito).
excepçao(jogo(ID,Nome,Valor)) :- jogo(ID, Nome, interdito).

excepçao(jogo(6,ff,250)).
excepçao(jogo(6,ff,X)) :- X>5000.

-jogo(7,gg,2500).
jogo(7,gg,xpto2).
excepçao(jogo(I,N,C)):-
	jogo(I,N,xpto2).

excepçao(jogo(8,hh,C)):- cercade(C,1000).
cercade(X,Y) :- A is 0.9*Y, B is 1.1*Y, X>=A, X=<B.

excepçao(jogo(9,ii,C)) :- cercade(C,3000).

%Invariantes

+jogo(I,A,C) :-	(solucoes(As,jogo(I,As,_),S),
				comprimento(S,N),
				N ==1).

+jogo(I,A,C) :- (solucoes(Is,jogo(Is,A,_),S),
				comprimento(S,N),
				N<=3).

+jogo(I,A,C) :- (solucoes(IS,jogo(IS,A,_),S),
				nao(seguido(S))).


head([H|T],H).

-seguido([]).
seguido([H|T]) :-
	head(T,P),
	H =:= P-1.

seguido([H|T]):-
	head(T,P),
	H \= P-1,
	seguido(T).

-jogo(I,A,C) :- nao(jogo(I,A,C)),nao(excepçao(jogo(I,A,C))).