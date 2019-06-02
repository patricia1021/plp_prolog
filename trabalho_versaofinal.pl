%Autores:
%Bruno Sales /brunosaales
%Patrícia Guimarães /patricia1021


%Predicados principais

%dadas as duas listas que recebe na entrada, vai desparentizar as sublistas
%e tirar as variáveis, vai contar o número de vezes de cada elemento que ficou,
%deletar as vezes em que aparecem os elementos repetidos e montar os pares.

conta_atomos([],[],[]):- !.
conta_atomos(L1, L2, Lout) :-
    desparentize(L1,Lout1),
    desparentize(L2,Lout2),
    subtracao(Lout1,Lout2,L),
    monta_pares(L,Lout),!.
    
desparentize([],[]):- !.
desparentize([Elem|Cauda],[Elem|Lout]) :-
    atomic(Elem),
    desparentize(Cauda, Lout),!. %caso em que a cabeça é um átomo.
desparentize([Elem|Cauda],Lout) :-
    var(Elem),
    desparentize(Cauda, Lout),!.%caso em que a cabeça é uma variável
desparentize([Elem|Cauda], Lout) :-
    is_list(Elem),
    desparentize(Elem, Lout1),
    desparentize(Cauda,Lout2),
    append(Lout1,Lout2,Lout),!.
 %caso em que é lista
desparentize([Elem|Cauda], [Elem|Lout]):-
                 desparentize(Cauda, Lout). 


subtracao(L1,L2,Lout) :-
    tira_comuns(L1,L2,Lout1),
    tira_comuns(L2,L1,Lout2),
    append(Lout1,Lout2,Lout),!.

tira_comuns([], _, []).  %Se a lista for vazia, retorna ela mesma.
tira_comuns([Elem|L1], L2, Lout):- 						  
					member(Elem,L2), tira_comuns(L1, L2, Lout), !.
tira_comuns([Elem|L1], L2, [Elem|Lout]):-  				  
					tira_comuns(L1, L2, Lout), !.

monta_pares([], []) :- !.
monta_pares([X|Cauda], [[X,Qtd]|Lout]):-
    conta_elemento(X, Cauda, N),
    Qtd is N + 1,
    deletar_todas(X, Cauda, L),
    monta_pares(L, Lout).

conta_elemento(_, [], 0) :- !.
conta_elemento(Elem, [Elem|Cauda], N) :-
    conta_elemento(Elem, Cauda, Qtd),
    N is Qtd + 1,!.
conta_elemento(Elem, [_|Cauda], N) :-
    conta_elemento(Elem, Cauda, N).

deletar_todas(_, [], []) :- !.
deletar_todas(Elem, [Elem|Cauda], Lout) :-
    deletar_todas(Elem, Cauda, Lout), !.
deletar_todas(Elem, [X|Cauda], [X|Lout]) :-
    deletar_todas(Elem, Cauda, Lout), !.



predicado_principal :- 
    write('Digite a primeira lista:'),  nl,
    read(L1),
    nl,
    write('Digite a segunda lista:'),  nl,
    read(L2),
    conta_atomos(L1, L2, Lout),
  write('Lista final: '), write(Lout).
