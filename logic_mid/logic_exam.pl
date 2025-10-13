edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(e, f).

path(Start, End, Path) :-
    path_acc(Start, End, [Start], Path).

%find a path between 2 nodes
path_acc(Current, End, Acc, Path) :-
    edge(Current, End),
    append(Acc, [End], Path).
path_acc(Current, End, Acc, Path) :-
    edge(Current, Next),
    \+ member(Next, Acc), %ensure to not create cycles
    append(Acc, [Next], Acc2),
    path_acc(Next, End, Acc2, Path).

% collect all paths and pick the one with minimal length
shortest_path(Start, End, Shortest) :-
    findall(Len-Path, (path(Start, End, Path), length(Path, Len)), Pairs),
    Pairs \= [],                     % fail if no paths
    keysort(Pairs, [ _MinLen-Shortest | _ ]).

