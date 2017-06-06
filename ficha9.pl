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
    teste( Lista ),
    insercao( Termo ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

%------------------------------------------------
%Extensão do predicado servico: servico, médico -> {V,F,D}

servico("Ortopedia","Amelia").
servico("Obstetricia","Ana").
servico("Obstetricia","Maria").
servico("Obstetricia","Mariana").
servico("Geriatria","Sofia").
servico("Geriatria","Susana").

excepçao(servico(xpt007,"Teodora")).
nulo(xpt007).

excepçao(servico(np9,"Zulmira")).
nulo(np9).
+servico(S,"Zulmira") :- (solucoes((SS,"Zulmira"),(servico(SS,"Zulmira"),nao(nulo(SS))),L),
				 comprimento(L,C),
				 C==0).

%Extensão do predicado atoMedico: ato,enfermeira,utente,data -> {V,F,D}

atoMedico("Penso","Ana","Joana","sabado").
atoMedico("Gesso","Amelia","Jose","domingo").

excepçao(atoMedico(xpt017,"Mariana","Joaquina","domingo")).
nulo(xpt017).

excepçao(atoMedico("Domicilio","Maria",xpt121,xpt251)).
nulo(xpt121).
nulo(xpt251).

excepçao(atoMedico("Domicilio","Susana","Joao","segunda")).
excepçao(atoMedico("Domicilio","Susana","Jose","segunda")).

excepçao(atoMedico("Sutura",xpt313,"Josue","segunda")).
nulo(xpto313).

excepçao(atoMedico("Sutura","Maria","Josefa","terca")).
excepçao(atoMedico("Sutura","Maria","Josefa","sexta")).
excepçao(atoMedico("Sutura","Mariana","Josefa","terca")).
excepçao(atoMedico("Sutura","Mariana","Josefa","sexta")).

excepçao(atoMedico("Penso","Ana","Jacinta",X)) :-
		(X="segunda";X="terca";X="quarta";
		X="quinta";X="sexta").

%----------------Invariantes-------------------
%impede registos de atos medicos em feriados

feriado("domingo").
+atoMedico(A,M,U,D) :- (solucoes((A,M,U,D),(atoMedico(A,M,U,D),nao(feriado(D))),L),
				 comprimento(L,C),
				 C==0).

%impede remoção de profissionais com atos registados

-servico(S,M) :- (solucoes(A,atoMedico(A,M,_,_),L),
				comprimento(L,C),
				C==0).

%prova a falsidade
-servico(S,M) :-
	nao(servico(S,M)), nao(excepçao(servico(S,M))).

-atoMedico(A,M,U,D) :-
	nao(atoMedico(A,M,U,D)), nao(excepçao(atoMedico(A,M,U,D))).