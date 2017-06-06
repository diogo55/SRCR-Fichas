:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').
:- dynamic '-'/1.
:- dynamic filho/3.
:- dynamic nasceu/2.
:- dynamic data/3.
:- dynamic servico/2.
:- dynamic atoMedico/4.


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

retrocesso(F) :- 
	solucoes(I,-F::I,L),
	testar(L),
	remove(F).


remove(T) :- retract(T).

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
servico("tuaprima","tuamae").

excepcao(servico(xpt007,"Teodora")).

excepcao(servico(np9,"Zulmira")).
nulo(np9).
+servico(S,"Zulmira") :- (solucoes((SS,"Zulmira"),(servico(SS,"Zulmira"),nao(nulo(SS))),L),
				 comprimento(L,C),
				 C==0).

%Extensão do predicado atoMedico: ato,enfermeira,utente,data -> {V,F,D}

atoMedico("Penso","Ana","Joana","sabado").
atoMedico("Gesso","Amelia","Jose","domingo").

excepcao(atoMedico(xpt017,"Mariana","Joaquina","domingo")).

excepcao(atoMedico("Domicilio","Maria",xpt121,xpt251)).

excepcao(atoMedico("Domicilio","Susana","Joao","segunda")).
excepcao(atoMedico("Domicilio","Susana","Jose","segunda")).

excepcao(atoMedico("Sutura",xpt313,"Josue","segunda")).

excepcao(atoMedico("Sutura","Maria","Josefa","terca")).
excepcao(atoMedico("Sutura","Maria","Josefa","sexta")).
excepcao(atoMedico("Sutura","Mariana","Josefa","terca")).
excepcao(atoMedico("Sutura","Mariana","Josefa","sexta")).

excepcao(atoMedico("Penso","Ana","Jacinta",X)) :-
		(X="segunda";X="terca";X="quarta";
		X="quinta";X="sexta").

%----------------Invariantes-------------------
%impede registos de atos medicos em feriados

feriado("domingo").
+atoMedico(A,M,U,D) :: (solucoes( (A,M,U,D),(atoMedico(A,M,U,D),feriado(D)),L),
				 		comprimento(L,C),
						 C==0).

%impede remoção de profissionais com atos registados

-servico(S,M) :: (solucoes((A),atoMedico(A,M,_,_),L),
				comprimento(L,C),
				C==0).

%prova a falsidade
-servico(S,M) :-
	nao(servico(S,M)), nao(excepcao(servico(S,M))).

-atoMedico(A,M,U,D) :-
	nao(atoMedico(A,M,U,D)), nao(excepcao(atoMedico(A,M,U,D))).