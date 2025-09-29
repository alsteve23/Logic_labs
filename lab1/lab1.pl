parent(jose, carlos).
parent(nohemi, carlos).
parent(jose, juan).
parent(juan, amelia).
parent(amelia, isabella).
parent(carlos, karen).
parent(jose, yadi).
parent(yadi, josue).
parent(josue, salome).
parent(yadi, steve).
parent(steve, pablo).

% 3. Reglas
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(Z, Y), ancestor(X, Z).

%Preferencias de comida
likes(alicia, pizza).
likes(juan, pizza).
likes(amelia, pasta).
likes(isabella, pizza).
likes(carlos, pasta).
likes(karen, pizza).
likes(josue, pasta).
likes(steve, pizza).
likes(pablo, pasta).
likes(salome, pizza).

% 6. Food friends: true si X e Y gustan de la misma comida y no son la misma persona
food_friend(X, Y) :- likes(X, Food), likes(Y, Food), X \= Y.

% 8. Factorial recursivo
factorial(0, 1).
factorial(N, F) :- N > 0, N1 is N-1, factorial(N1, F1), F is N * F1.

% 9. Suma de una lista
sum_list([], 0).
sum_list([H|T], S) :- sum_list(T, S1), S is H + S1.

% 10. List Processing
% 11. Longitud de una lista
length_list([], 0).
length_list([_|T], L) :- length_list(T, L1), L is L1 + 1.

% 12. Append de dos listas
append_list([], L, L).
append_list([H|T], L2, [H|R]) :- append_list(T, L2, R).

