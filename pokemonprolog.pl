%==========================================================================
% FATOS/TIPOS:
%==========================================================================

% Elétrico

ataque_super_efetivo(eletrico, agua).
ataque_super_efetivo(eletrico, voador).

ataque_pouco_efetivo(eletrico, eletrico).
ataque_pouco_efetivo(eletrico, grama).
ataque_pouco_efetivo(eletrico, dragao).

ataque_sem_efeito(eletrico, terra).

% Metal

ataque_super_efetivo(metal, fada).
ataque_super_efetivo(metal, gelo).
ataque_super_efetivo(metal, pedra).

ataque_pouco_efetivo(metal, fogo).
ataque_pouco_efetivo(metal, agua).
ataque_pouco_efetivo(metal, eletrico).
ataque_pouco_efetivo(metal, metal).

% Terra

ataque_super_efetivo(terra, metal).
ataque_super_efetivo(terra, eletrico).
ataque_super_efetivo(terra, fogo).
ataque_super_efetivo(terra, pedra).
ataque_super_efetivo(terra, veneno).

ataque_pouco_efetivo(terra, grama).
ataque_pouco_efetivo(terra, inseto).

ataque_sem_efeito(terra, voador).

% Gelo

ataque_super_efetivo(gelo, dragao).
ataque_super_efetivo(gelo, grama).
ataque_super_efetivo(gelo, terra).
ataque_super_efetivo(gelo, voador).

ataque_pouco_efetivo(gelo, metal).
ataque_pouco_efetivo(gelo, agua).
ataque_pouco_efetivo(gelo, fogo).
ataque_pouco_efetivo(gelo, gelo).

% Pedra

ataque_super_efetivo(pedra, fogo).
ataque_super_efetivo(pedra, gelo).
ataque_super_efetivo(pedra, inseto).
ataque_super_efetivo(pedra, voador).

ataque_pouco_efetivo(pedra, metal).
ataque_pouco_efetivo(pedra, lutador).
ataque_pouco_efetivo(pedra, terra).

% Dragão

ataque_super_efetivo(dragao, dragao).

ataque_pouco_efetivo(dragao, metal).

ataque_sem_efeito(dragao, fada).

% Voador

ataque_super_efetivo(voador, grama).
ataque_super_efetivo(voador, lutador).
ataque_super_efetivo(voador, inseto).

ataque_pouco_efetivo(voador, eletrico).
ataque_pouco_efetivo(voador, pedra).
ataque_pouco_efetivo(voador, metal).

% Lutador

ataque_super_efetivo(lutador, normal).
ataque_super_efetivo(lutador, gelo).
ataque_super_efetivo(lutador, pedra).
ataque_super_efetivo(lutador, sombrio).
ataque_super_efetivo(lutador, metal).

ataque_pouco_efetivo(lutador, veneno).
ataque_pouco_efetivo(lutador, voador).
ataque_pouco_efetivo(lutador, psiquico).
ataque_pouco_efetivo(lutador, inseto).
ataque_pouco_efetivo(lutador, fada).

ataque_sem_efeito(lutador, fantasma).

% Fogo

ataque_super_efetivo(fogo, grama).
ataque_super_efetivo(fogo, gelo).
ataque_super_efetivo(fogo, inseto).
ataque_super_efetivo(fogo, metal).

ataque_pouco_efetivo(fogo, fogo).
ataque_pouco_efetivo(fogo, agua).
ataque_pouco_efetivo(fogo, pedra).
ataque_pouco_efetivo(fogo, dragao).

% Grama

ataque_super_efetivo(grama, agua).
ataque_super_efetivo(grama, terra).
ataque_super_efetivo(grama, pedra).

ataque_pouco_efetivo(grama, fogo).
ataque_pouco_efetivo(grama, grama).
ataque_pouco_efetivo(grama, veneno).
ataque_pouco_efetivo(grama, voador).
ataque_pouco_efetivo(grama, inseto).
ataque_pouco_efetivo(grama, dragao).
ataque_pouco_efetivo(grama, metal).

% Água

ataque_super_efetivo(agua, fogo).
ataque_super_efetivo(agua, terra).
ataque_super_efetivo(agua, pedra).

ataque_pouco_efetivo(agua, agua).
ataque_pouco_efetivo(agua, grama).
ataque_pouco_efetivo(agua, dragao).

% Fantasma

ataque_super_efetivo(fantasma, psiquico).
ataque_super_efetivo(fantasma, fantasma).

ataque_pouco_efetivo(fantasma, sombrio).

ataque_sem_efeito(fantasma, normal).

% Inseto

ataque_super_efetivo(inseto, grama).
ataque_super_efetivo(inseto, psiquico).
ataque_super_efetivo(inseto, sombrio).

ataque_pouco_efetivo(inseto, fogo).
ataque_pouco_efetivo(inseto, lutador).
ataque_pouco_efetivo(inseto, veneno).
ataque_pouco_efetivo(inseto, voador).
ataque_pouco_efetivo(inseto, fantasma).
ataque_pouco_efetivo(inseto, metal).
ataque_pouco_efetivo(inseto, fada).

% Fada

ataque_super_efetivo(fada, lutador).
ataque_super_efetivo(fada, dragao).
ataque_super_efetivo(fada, sombrio).

ataque_pouco_efetivo(fada, fogo).
ataque_pouco_efetivo(fada, veneno).
ataque_pouco_efetivo(fada, metal).

%==========================================================================
% INFERÊNCIAS/CÁLCULOS DE TIPO:
%==========================================================================

% Efetividade individual

efetividade_individual(A, T, sem_efeito) :-
ataque_sem_efeito(A, T), !.

efetividade_individual(A, T, super_efetivo) :-
ataque_super_efetivo(A, T), !.

efetividade_individual(A, T, pouco_efetivo) :-
ataque_pouco_efetivo(A, T), !.

efetividade_individual(_, _, neutro).

% Combinação de tipos

% Imunidade
combinar(sem_efeito, _, sem_efeito) :- !.
combinar(_, sem_efeito, sem_efeito) :- !.

% Super efetivo + super efetivo
combinar(super_efetivo, super_efetivo, muito_efetivo).

% Super efetivo + neutro
combinar(super_efetivo, neutro, super_efetivo).
combinar(neutro, super_efetivo, super_efetivo).

% Super efetivo + pouco efetivo
combinar(super_efetivo, pouco_efetivo, neutro).
combinar(pouco_efetivo, super_efetivo, neutro).

% Neutro + neutro
combinar(neutro, neutro, neutro).

% Pouco efetivo + neutro
combinar(pouco_efetivo, neutro, pouco_efetivo).
combinar(neutro, pouco_efetivo, pouco_efetivo).

% Pouco efetivo + pouco efetivo
combinar(pouco_efetivo, pouco_efetivo, muito_pouco_efetivo).

% Cálculo final de ataque

resultado_ataque(A, T1, T2, Resultado) :-
    efetividade_individual(A, T1, E1),
    efetividade_individual(A, T2, E2),
    combinar(E1, E2, Resultado).

% Pokémon de tipo único

resultado_ataque(A, T, Resultado) :-
efetividade_individual(A, T, Resultado).

% ==========================================================
% CONTADOR DE VANTAGENS
% ==========================================================

% Contagem de vantagens ofensivas

contar_vantagens(Tipo, Total) :-
    findall(
        Alvo,
        ataque_super_efetivo(Tipo, Alvo),
        Lista
    ),
    length(Lista, Total).

% Contagem de fraquzas defensivas

contar_fraquezas(Tipo, Total) :-
    findall(
        Ataque,
        ataque_super_efetivo(Ataque, Tipo),
        Lista
    ),
    length(Lista, Total).

% Contagem de imunidades ofensivas

contar_imunidades_ofensivas(Tipo, Total) :-
    findall(
        Alvo,
        ataque_sem_efeito(Tipo, Alvo),
        Lista
    ),
    length(Lista, Total).

% Contagem de imunidades defensivas

contar_imunidades_defensivas(Tipo, Total) :-
    findall(
        Ataque,
        ataque_sem_efeito(Ataque, Tipo),
        Lista
    ),
    length(Lista, Total).

% ==========================================================
% RELATORIO COMPLETO
% ==========================================================

relatorio_tipo(Tipo) :-
    contar_vantagens(Tipo, Vantagens),
    contar_fraquezas(Tipo, Fraquezas),
    contar_imunidades_ofensivas(Tipo, ImunidadesO),
    contar_imunidades_defensivas(Tipo, ImunidadesD),

    write('Tipo: '), write(Tipo), nl,
    write('Vantagens ofensivas: '), write(Vantagens), nl,
    write('Fraquezas defensivas: '), write(Fraquezas), nl,
    write('Imunidades ofensivas: '), write(ImunidadesO), nl,
    write('Imunidades defensivas: '), write(ImunidadesD), nl.
