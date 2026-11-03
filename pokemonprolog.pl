
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

% Cálculo final

resultado_ataque(A, T1, T2, Resultado) :-
efetividade_individual(A, T1, E1),
efetividade_individual(A, T2, E2),
combinar(E1, E2, Resultado).

% Pokémon de tipo único

resultado_ataque(A, T, Resultado) :-
efetividade_individual(A, T, Resultado).
