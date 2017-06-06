:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').
:- dynamic '-'/1.
:- dynamic filho/3.
:- dynamic nasceu/2.
:- dynamic data/3.

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


%------------------------------------------------------------------

%Extensão do predicado filho:filho,pai,mae ->{V,F,D}

filho("Ana","Abel","Alice").

filho("Anibal","Antonio","Alberta").

filho("Berta","Bras","Belem").
filho("Berto","Bras","Belem").

excepçao(filho("Crispim","Celso","Catia")).
excepçao(filho("Crispim","Caio","Catia")).

filho("Danilo","Daniel",mae01).
excepçao((filho(X,P,M)):- filho(X,P,mae01)).

filho("Eurico","Elias","Elsa").

excepçao(filho("Fausto","Fabia",mae02)).
excepçao(filho("Fausto","Otavia",mae02)).
excepçao((filho(X,P,M)):- filho(X,P,mae02)).

filho("Golias","Guido","Guida")).


%Extensão do predicado data: pessoa,dia, mes, ano -> {V,F}

data("Ana",1,1,2010).
data("Anibal",2,1,2010).
data("Berta",2,2,2010).
data("Berto",2,2,2010).
data("Catia",3,3,2010).
data("Danilo",4,4,2010).
excepçao(data("Eurico",5,5,2010)).
excepçao(data("Eurico",15,5,2010)).
excepçao(data("Eurico",25,5,2010)).
excepçao(data("Golias",interdito,interdito,interdito)).
nulo(interdito).
+data(P,D,M,A) :: (solucoes((D,M,A),(data("Golias",D,M,A),nao(nulo(D),nao(nulo(M),nao(nulo(A)))),S),
                comprimento(S,N), N==0).

-data("Helder",8,8,2010).
excepçao(data("Ivo",D,6,2010)):-
	D>0,
	D=<15.


%--------------------------------------------------
%Nao se admite a existencia de mais do que uma ocorrencia da 
%mesma evidencia na relacao filho:

+filho(F,P,M) :: (solucoes( (F,P,M) , ( filho(F,P,M) ) , S) ,
	comprimento(S,N) , 
	N==1) .

% Nao é admissivel existirem mais do que 2 progenitores 
%para um determinado individuo
+filho(F,P,M)::(solucoes((Ps,Ms),(filho(F,Ps,Ms)),S),
				comprimento(S,N),
				N=<2).

%Nao se admitira a existencia de mais do que uma data de nascimento:
+data(N,D,M,A)::(solucoes((Ds,Ms,As),(data(N,Ds,Ms,As)),S),
 				 comprimento(S,C),
 				 C==1).

% Predicado para provar factos falsos :
-filho(F,P,M) :- nao(filho(F,P,M)), nao(excepcao(filho(F,P,M))).

% Predicado para provar factos falsos :
-data(N,D,M,A) :-  nao( data(N,D,M,A) ) , nao(excepcao(dara(N,D,M,A))).