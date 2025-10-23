% edge(entrance,	a).	
% edge(a,	b).	
% edge(a,	c).	
% edge(b,	exit).	
% edge(c,	b).	
% blocked(a,	c).		%	Door	is	blocked	from	a	to	c.

edge(entrance,e).
edge(a,entrance).
edge(a,b).
edge(a,f).
edge(b,a).
edge(b,c).
edge(b,g).
edge(c,b).
edge(c,h).
edge(c,d).
edge(d,c).
edge(d,i).
edge(e,entrance).
edge(e,f).
edge(e,j).
edge(f,e).
edge(f,g).
edge(f,a).
edge(f,k).
edge(g,f).
edge(g,h).
edge(g,b).
edge(g,m).
edge(h,g).
edge(h,c).
edge(h,n).
edge(h,i).
edge(i,d).
edge(i,o).
edge(i,h).
edge(j,p).
edge(j,k).
edge(j,p).
edge(k,j).
edge(k,m).
edge(k,f).
edge(k,q).
edge(m,k).
edge(m,r).
edge(m,g).
edge(m,n).
edge(n,s).
edge(n,h).
edge(n,m).
edge(n,o).
edge(o,n).
edge(o,i).
edge(o,t).
edge(p,j).
edge(p,q).
edge(p,u).
edge(q,p).
edge(q,v).
edge(q,k).
edge(q,f).
edge(r,m).
edge(r,q).
edge(r,s).
edge(r,w).
edge(s,n).
edge(s,x).
edge(s,r).
edge(s,t).
edge(t,exit).
edge(t,s).
edge(t,o).
edge(u,v).
edge(u,p).
edge(v,u).
edge(v,q).
edge(v,w).
edge(w,r).
edge(w,x).
edge(w,v).
edge(x,w).
edge(x,s).
edge(x,exit).
edge(exit,x).
edge(exit,t).

blocked(entrance,a).
blocked(a,entrance).
% blocked(a,f).
% blocked(f,a).
% blocked(g,b).
% blocked(b,g).
blocked(h,i).
blocked(i,h).
blocked(n,h).
blocked(h,n).
blocked(m,n).
blocked(n,m).
blocked(m,g).
blocked(g,m).
blocked(k,f).
blocked(f,k).
blocked(e,j).
blocked(j,e).
blocked(q,k).
blocked(k,q).
blocked(q,r).
blocked(r,q).
blocked(r,s).
blocked(s,r).
blocked(s,t).
blocked(t,s).
blocked(t,o).
blocked(o,t).
blocked(u,p).
blocked(p,u).
blocked(v,w).
blocked(w,v).



%reglas
can_move(X,Y):-edge(X,Y),\+ blocked(X,Y).
reason(X,Y,Visited,'path is open'):-can_move(X,Y),!.
reason(X,Y,Visited,'path is blocked'):-blocked(X,Y),!.
reason(X,Y,Visited,'loop detected'):-member(Y,Visited),!.
reason(X,Y,Visited,'destination is reached'):-Y==exit,!.

%Razonando
why(X,Y):-
    format('Analizing...the move from ~w to ~w.~n',[X,Y]),
    (reason(X,Y,Visited,Reason)->
        format('Reason: ~w.~n',[Reason])
    ;
        format('Reason not defined.~n')
    ).

%Caso base: Haya un camino directo entre el nodo actual y el nodo final
move(X,Y,Visited,[Y|Visited]):-
    can_move(X,Y),
    format('Moving from ~w to ~w.Reason:~w. ~n', [X,Y,Reason]),
    count_visited(Visited,Count),
    format('Nodes counter: ~w.~n',[Count]).

%Recursion: haya un nodo intermedio entre la entrada y el nodo final
move(X,Y,Visited, Path):-
    can_move(X,Z),
    reason(X,Z,Visited,Reason),
    \+ member(Z,Visited),
    format('Exploring from ~w to ~w....Result: ~w.~n',[X,Z,Reason]),
    move(Z,Y,[Z|Visited],Path).

%Llama a la funcion move y devuelve la lista que contiene el camino
find_path(X,Y,Path):-
    move(X,Y,[X],RevPath),
    reverse(RevPath,Path).

%Cuenta los nodos visitados
count_visited(Path,Count):-
    length(Path,Count).

%Imprimie el camino final como respuesta
print_path(X,Y):-
    (find_path(X,Y,Path)->
        write('Path: '),write(Path),nl
    ;
    write('No path found from '), write(X), write(' to '), write(Y), nl
    ).
