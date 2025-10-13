%Graph creation
edge(node1 ,node2 ).
edge(node2 ,node3 ).
edge(node1 ,node4 ).
edge(node4 ,node3 ).
edge(node3, node1 ).



%maze creation
edge(start,e).
edge(c,b).
edge(c,d).
edge(e,f).
edge(f,k).
edge(g,l).
edge(l,r).
edge(b,h).
edge(h,m).
edge(xd,c).
edge(i,xd).
edge(o,i).
edge(p,j).
edge(k,l).
edge(a,e).
edge(m,n).
edge(p,o).
edge(w,q).
edge(r,l).
edge(r,x).
edge(t,s).
edge(n,t).
edge(b1,u).
edge(c1,v).
edge(v,p).
edge(x,w).
edge(s,z).
edge(t,a1).
edge(a1,b1).
edge(d1,c1).
edge(c1,d1).
edge(w,d1).
edge(d1,e1).
edge(e1,exit).
edge(z,p1).
edge(p1,g1).
edge(a1,g1).
edge(g1,a1).
edge(i1,h1).
edge(i1,c1).
edge(v1,i1).

% path/2
path(X, Y) :-
	path_search(X, Y, []).

% path search that avoids cycles
path_search(X, Y, _) :-
	edge(X, Y).
path_search(X, Y, Visited) :-
	edge(X, Z),
	\+ member(Z, Visited),
	path_search(Z, Y, [X|Visited]).

% Public path/3 to use findall/3
path(X, Y, Path) :-
	path_acc(X, Y, [X], Path).

% path_acc(Current, End, Acc, Path) builds Path (list) using accumulator
path_acc(Current, End, Acc, Path) :-
	edge(Current, End),
	append(Acc, [End], Path).
path_acc(Current, End, Acc, Path) :-
	edge(Current, Next),
	\+ member(Next, Acc),
	append(Acc, [Next], Acc2),
	path_acc(Next, End, Acc2, Path).

% collect all paths and pick the one with minimal length
shortest_path(Start, End, Shortest) :-
    findall(Len-Path, (path(Start, End, Path), length(Path, Len)), Pairs),
    Pairs \= [],                     % fail if no paths
    keysort(Pairs, [ _MinLen-Shortest | _ ]).

% print_shortest_path(Start, End): prints one shortest path between Start and End
print_shortest_path(Start, End) :-
    ( shortest_path(Start, End, P) ->
        write('Shortest path: '), write(P), nl
    ;
        write('No path found from '), write(Start), write(' to '), write(End), nl
    ).

