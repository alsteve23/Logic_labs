:- use_module(library(clpfd)).

schedule(Tasks,Starts,Ends,Makespan):-
    findall(D, member(task(_,D,_), Tasks), Durations),
    findall(R, member(task(_,_,R), Tasks), Resources),
    length(Tasks,N),
    length(Starts,N),
    length(Ends,N),
    Starts ins 0..100,
    Ends ins 0..100,
    maplist(add_end, Starts,Durations,Ends),
    no_overlap(Starts,Durations,Resources),
    maximum_fd(Makespan, Ends),
    Makespan in 0..100,
    append(Starts, [Makespan], Vars),
    labeling([min(Makespan)],Vars),
    print_result(Tasks,Starts,Ends, Makespan).



add_end(S,D,E):-E#=S+D.

    
no_overlap([],[],[]).
no_overlap([S|Ss],[D|Ds],[R|Rs]):-
    no_overlap_with_same_resource(S,D,R,Ss,Ds,Rs),
    no_overlap(Ss,Ds,Rs).

no_overlap_with_same_resource(_,_,_,[],[],[]).
no_overlap_with_same_resource(S1,D1,R1,[S2|Ss],[D2|Ds],[R2|Rs]):-
    (R1#=R2->
        (S1+D1#=<S2)#\/(S2+D2#=<S1)
    ; true),
    no_overlap_with_same_resource(S1,D1,R1,Ss,Ds,Rs).

maximum_fd(Max, List) :-
    foldl(max_fd, List, 0, Max).

max_fd(X, Acc, Max) :-
    Max #= max(X, Acc).

print_result([],[],[],Makespan):-
    format('Makespan: ~w~n',[Makespan]).
print_result([task(Name,Dur,R)|Ts],[S|Ss],[E|Es],Makespan):-
    format('~w: start:~w, end:~w duration:~w, res:~w.~n',[Name,S,E,Dur,R]),
    print_result(Ts,Ss,Es,Makespan).

%Test1
%schedule([task(a,3,1), task(b,2,1), task(c,4,2)], S, E, M).

%Test2
%schedule([task(a,5,1), task(b,2,1), task(c,8,1)], S, E, M).

%Test3
%schedule([task(a,5,1), task(b,2,2), task(c,8,1), task(d,5,2),task(e,10,3)], S, E, M).
