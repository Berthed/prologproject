
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

ataque_pouco_efetivo(terra, planta).
ataque_pouco_efetivo(terra, inseto).

ataque_sem_efeito(terra, voador).

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
