:- dynamic filho/2.
:- dynamic pai/2.
:- dynamic avo/2.
:- dynamic neto/2.
:- dynamic masculino/1.
:- dynamic feminino/1.
:- dynamic descendente/2.
:- dynamic descendente/3.

% Extensao do predicado filho: Filho,Pai -> {V,F}

filho("Joao","Jose").
filho("Jose","Manuel").
filho("Carlos","Jose").


% Extensao do predicado pai: Pai,Filho -> {V,F}

pai(P,F) :-
	filho(F,P).

pai("Paulo","Filipe").
pai("Paulo","Maria").

% Extensao do predicado avo: Avo,Neto -> {V,F}

avo(A,N) :-
	filho(N,X),
	pai(A,X).

avo(A,N):-
	descendenteGrau(N,A,2).

avo("Antonio","Nadia").

%Extensão do predicado neto: Neto, Avo -> {V,F}

neto(N,A) :-
	avo(A,N).

%Extensao do predicado masculino: Homem ->{V,F}

masculino("Joao").
masculino("Jose").

% Extansão do predicado feminino: Mulher -> {V,F}

feminino(F):-
	\+ masculino(F).
% \+ se nao (\) for possivel provar que(+)... 

feminino("Maria").
feminino("Joana").

%Extensão do predicado descendente: descendente,ascendente -> {V,F}

descentende(D,A):-
	filho(D,A).

descendente(D,A):-
	avo(A,D).

descendente(D,A) :-
	pai(A,D).

descendente(D,A) :-
	filho(D,X),
	descendente(X,A).

%Extensão do predicado descendenteGrau: descendente,ascendente,grau -> {V,F}

descendenteGrau(D,A,G):-
	filho(D,A),
	G is 1.

descendenteGrau(D,A,G) :-
	filho(D,X),
	descendenteGrau(X,A,Z),
	G is Z+1.


%Extensão do predicado bisavô: bisavô,bisneto -> {V,F}

bisavo(B,BN) :-
	descendenteGrau(BN,B,3).


%Extensão do predicado trisavô: trisavô,trisneto -> {V,F}

trisavo(T,TN) :-
	descendenteGrau(TN,T,4).

%Extensão do predicado tetraneto: tetraneto,tetra-avo -> {V,F}

tetraneto(TN,T) :-
	descendenteGrau(TN,T,5).


%------------------Segunda Parte----------------

ficha01(xx)       :- filho("Joao", "Jose"). %true
ficha01(xxi)      :- pai("Jose", "Joao").	%true
ficha01(xxii)     :- masculino("Joao").		%true
ficha01(xxiii)    :- feminino("Jose").		%false
ficha01(xxiv)     :- filho(_,"Jose").		%true
ficha01(xxv)      :- filho("Jose", "Joao").	%false
ficha01(xxvi)     :- avo("Manuel", "Jose"). %false
ficha01(xxvii)    :- avo("Manuel", "Joao"). %true
ficha01(xxviii)   :- neto("Carlos", _).		%true
ficha01(xxix)     :- descendente("Joao", "Manuel").	%true
ficha01(xxx)      :- filho(X,"Jose"), descendente(X,"Manuel").	%true
ficha01(xxxi)     :- descendente(X, "Manuel"), filho(X, "Jose").%true
ficha01(xxxii, G) :- descendenteGrau("Joao","Jose", G).		%G = 1.
ficha01(xxxiii)   :- descendenteGrau("Joao","Jose", 2). 	%false
ficha01(xxxiv, G) :- descendenteGrau("Joao", "Manuel", G).	%G = 2.
ficha01(xxxv)     :- descendenteGrau("Joao", "Manuel", G), G > 2. %false