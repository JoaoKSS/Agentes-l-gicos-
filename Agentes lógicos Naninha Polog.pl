:- dynamic aqui/1, localizacao/2, tem/1, desafio/1, porta/2.

comodo(cozinha).
comodo(escritorio).
comodo(entrada).
comodo('sala de jantar').
comodo(lavanderia).
comodo(exterior).
comodo(casa).

localizacao(mesa, escritorio).
localizacao(lanterna, escritorio).
localizacao(maca,cozinha).
localizacao(biscoitos,cozinha).
localizacao(brocolis, cozinha).
localizacao(naninha, lavanderia).
localizacao(computador, escritorio).
localizacao(chave, 'sala de jantar').
localizacao(gerador, exterior).
localizacao(pombo, exterior).
localizacao(energia, casa).
localizacao('fechadura eletronica', cozinha).

porta(escritorio, entrada).
porta(cozinha, escritorio).
porta(entrada, 'sala de jantar').
%porta(cozinha,lavanderia).
porta('sala de jantar', cozinha).
porta(exterior, entrada).

aqui(cozinha).
%aqui('sala de jantar').
%aqui(exterior).

%regras

conecta(X,Y):-porta(X,Y).
conecta(X,Y):-porta(Y,X).

lista_coisas(Lugar):-
    localizacao(X, Lugar),
    write(X),
    nl, fail.

lista_coisas(_).

lista_conexoes(Lugar):-
    conecta(Lugar,X),
    write(X),
    nl, fail.

lista_conexoes(_).

veja:-
   aqui(Lugar),
   write('Voce esta no/na '), write(Lugar),
   nl,
   write('Voce pode ver: '), nl,
   lista_coisas(Lugar),
   write('Voce pode ir: '), nl,
   lista_conexoes(Lugar).

pode_ir(Lugar):-
    aqui(X),
    conecta(X, Lugar).

pode_ir(Lugar):-
    aqui(X),
    conecta(X, Lugar).

pode_ir(_):-
    write('Voce nao pode ir ate la'), nl, fail.

mova(Lugar):-
    retract(aqui(_)),
    asserta(aqui(Lugar)).

pegue(X):-
    pode_pegar(X),
    pegue_objeto(X).

pegue(_).

% NOVO CASO ADICIONADO:
pode_pegar(Coisa):-
    Coisa == gerador,
    write('O gerador é muito pesado para carregar.'), nl, !, fail.

% NOVO CASO ADICIONADO:
pode_pegar(Coisa):-
    Coisa == 'fechadura eletronica',
    write('A fechadura esta presa na porta.'), nl, !, fail.

pode_pegar(Coisa):-
    aqui(Lugar),
    localizacao(Coisa,Lugar), !.

pode_pegar(Coisa):-
    write('Nao existe nenhuma (a) '), write(Coisa),
          write(' aqui.'), nl, fail.

%Adição de joão

pegue_objeto(X):-
    retract(localizacao(X,_)),
    asserta(tem(X)),
    write('Peguei!'), nl.

% interação com objetos (ajustada)
% caso especial: ligar gerador estando no mesmo cômodo
pode_interagir(gerador):-
    aqui(Lugar),
    localizacao(gerador, Lugar), !.

pode_interagir(gerador):-
	write('Você não pode interagir com o gerador agora.'),nl, !, fail.


pode_interagir('fechadura eletronica'):-
    aqui(Lugar),
    localizacao('fechadura eletronica', Lugar),
    localizacao(casa, energia),!.

pode_interagir('fechadura eletronica'):-
	write('Você não pode interagir com a fechadura eletronica agora.'),nl, !, fail.

% caso padrão: só se estiver carregando o objeto
pode_interagir(lanterna):-
    tem(lanterna), !.

pode_interagir(lanterna):-
	write('Você não pode interagir com a lanterna agora.'),nl, !, fail.

pode_interagir(Coisa):-
    tem(Coisa), !.

% se não satisfaz os casos acima, falha sem mensagem extra
pode_interagir(_):- !, fail.

interaja(X):-
    pode_interagir(X),
    interaja_objeto(X).
% silencia qualquer outra tentativa de interação
interaja(_):- !.

interaja_objeto(X):-
    X == lanterna,%entre aspas é tem lanterna
    asserta(localizacao(casa, luz)),
    write('liguei a lanterna'), nl.

interaja_objeto(X):-
    X == gerador,%entre aspas é tem gerador
    asserta(localizacao(casa, energia)),
    write('liguei o gerador'), nl.

interaja_objeto(X):-
    X == ('fechadura eletronica'),
    retract(localizacao('fechadura eletronica', cozinha)),
    assert(porta(cozinha,lavanderia)),
    write('Destranquei a porta'), nl.

% comando goto com desafio de escuridão e tranca
goto(Lugar):-
    desafio(goto(Lugar)),
    pode_ir(Lugar),
    mova(Lugar), veja.
goto(_).

desafio(goto(exterior)) :-
    tem(chave),
    localizacao(casa, luz), !. 

% NOVO CASO ADICIONADO:
desafio(goto(exterior)):-
    \+ localizacao(casa, luz),
    write('Esta escuro e você tem medo do escuro. Pegue a lanterna e a ligue!!'),nl,!, fail.

% NOVO CASO ADICIONADO:
desafio(goto(exterior)) :-
    \+ tem(chave),
    write('A porta está trancada . Você precisa da chave!!'), nl, !, fail.

desafio(_).

loop:-
    write('Bem-vindo(a) a busca da naninha'),
    nl,
    repeat,
    write('>naninha> '),
    read(X),
    desafio(X),
    do(X), (X=fim,!; nl,
    fim_condicao(X)).

do(goto(X)):-goto(X),!.
do(tem(X)):-tem(X),!.
do(veja):-veja,!.
do(pegue(X)):-pegue(X), !.
% NOVO CASO ADICIONADO:
do(interaja(X)):- interaja(X), !.
do(fim).
do(_):- write('Comando invalido').

fim_condicao(fim):-write('Você encerrou o jogo.').
fim_condicao(_):-  
    tem(naninha),
    write('Parabéns, voce ganhou').