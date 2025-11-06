:-use_module(library(clpfd)).

%declarando las regiones adyacentes.
adjacent(wa,nt).
adjacent(wa,sa).
adjacent(nt,sa).
adjacent(nt,q).
adjacent(sa,q).
adjacent(sa,nsw).
adjacent(sa,v).
adjacent(q,nsw).
adjacent(nsw,v).

adjacent(nsw,v).

%returns	the	ordered	list	of	region	atoms	for	Australia.
regions_au(Regions) :-
    setof(R, Neighbor^(adjacent(R,Neighbor) ; adjacent(Neighbor,R)), Regions).

%returns a list	of pairs A-B representing adjacencies.
edges_au(Pairs):-
    findall(A-B,adjacent(A,B), Pairs).

%color name mapping [1=red, 2=green,	3=blue,	4=yellow].
color_names(Colors):-
    Colors=[1-red,2-green,3-blue,4-yellow].	

%core	constraint	model	for	any	map.	
map_color(Vars,Pairs,K):-
    Vars ins 1..K,
    maplist(apply_constraint(Vars),Pairs).

apply_constraint(Vars, A-B):-
    regions_au(Regions),
    nth1(IdxA, Regions, A),
    nth1(IdxB, Regions, B),
    nth1(IdxA, Vars,ColorA),
    nth1(IdxB, Vars, ColorB),
    ColorA#\=ColorB.

% apply_constraint_generic(Regions, Vars, RegionA-RegionB) :-
%     nth1(IdxA, Regions, RegionA),
%     nth1(IdxB, Regions, RegionB),
%     nth1(IdxA, Vars, ColorA),
%     nth1(IdxB, Vars, ColorB),
%     ColorA #\= ColorB.

%Ties it all together for Auatralia..
colorize_au(K,Vars):-
    regions_au(Regions),
    edges_au(Pairs),
    length(Regions,N),
    length(Vars, N),
    map_color(Vars,Pairs,K),
    labeling([], Vars).

pretty_color_by_region(Regions,Vars):-
    color_names(ColorMap),
    print_helper(Regions,Vars,ColorMap).

print_helper([],[],_).
print_helper([Region|Rs],[ColorNum|Vs], ColorMap):-
    memberchk(ColorNum-ColorName, ColorMap),
    format('~w=~w~n',[Region,ColorName]),
    print_helper(Rs,Vs,ColorMap).
    

    

print_list(_Start, Final) :-
    ( regions_au(Final) ->
        write(Final)
    ;
        write('Solucion no encontrada')
    ).


%Sudamerica
adjacent_sa(ar, bo).
adjacent_sa(ar, br).
adjacent_sa(ar, ch).
adjacent_sa(ar, py).
adjacent_sa(ar, uy).
adjacent_sa(bo, br).
adjacent_sa(bo, ch).
adjacent_sa(bo, pe).
adjacent_sa(bo, py).
adjacent_sa(br, co).
adjacent_sa(br, gfr).
adjacent_sa(br, gy).
adjacent_sa(br, pe).
adjacent_sa(br, py).
adjacent_sa(br, su).
adjacent_sa(br, uy).
adjacent_sa(br, ve).
adjacent_sa(ch, pe).
adjacent_sa(co, ec).
adjacent_sa(co, pe).
adjacent_sa(co, ve).
adjacent_sa(ec, pe).
adjacent_sa(gfr, su).
adjacent_sa(gy, su).
adjacent_sa(gy, ve).
adjacent_sa(su, ve).

%returns	the	ordered	list	of	region	atoms	for	Australia.
regions_sa(Regions) :-
    setof(R, Neighbor^(adjacent_sa(R,Neighbor) ; adjacent_sa(Neighbor,R)), Regions).
    %write(Regions).

%returns a list	of pairs A-B representing adjacencies.
edges_sa(Edges):-
    findall(A-B,adjacent_sa(A,B), Edges).

map_color_sa(Vars, Edges, K) :-
    Vars ins 1..K,
    maplist(apply_constraint_sa(Vars), Edges).

apply_constraint_sa(Vars, RegionA-RegionB) :-
    regions_sa(Regions),
    nth1(IdxA, Regions, RegionA),
    nth1(IdxB, Regions, RegionB),
    nth1(IdxA, Vars, ColorA),
    nth1(IdxB, Vars, ColorB),
    ColorA #\= ColorB.

colorize_sa(K,Vars):-
    regions_sa(Regions),
    edges_sa(Edges),
    length(Regions,N),
    length(Vars, N),
    map_color_sa(Vars,Edges,K),
    labeling([], Vars).

pretty_color_sa(Vars):-
    regions_sa(Regions),
    pretty_color_by_region(Regions,Vars).