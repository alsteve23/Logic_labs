:-	use_module(library(clpfd)).	

%Define los bloques 3x3 del sudoku
blocks([]).	
blocks([A,B,C|Rest])	:-	
blocks3(A,	B,	C),	blocks(Rest).

%define el grid 9x9 del sudoku
blocks3([],	[],	[]).	
blocks3([A1,A2,A3|R1],[B1,B2,B3|R2],[C1,C2,C3|R3])	:-	
all_different([A1,A2,A3,B1,B2,B3,C1,C2,C3]),	
blocks3(R1,	R2,	R3).


sudoku(Rows):-	
append(Rows,Vars),Vars ins 1..9,	
maplist(all_different,Rows),	
transpose(Rows,Columns),maplist(all_different,Columns),	
blocks(Rows),maplist(label,Rows).	

%separador para la cuadricula
print_separator:-
    write('+------+-------+-------+'),nl.


%separador vertical
print_row(Row):-
    write('|'),
    print_cells(Row,1),
    nl.


%separador 3x3
print_cells([],_). %caso base
%caso recursivo
print_cells([Cell|Rest], N) :-
    (var(Cell)->write('_');write(Cell)),
    write(' '), 
    (N mod 3 =:= 0 -> write('| ');true),
    N1 is N+1,
    print_cells(Rest,N1).


%funcion para imprimir lineas
print_rows([],_). %caso base
%caso recursivo
print_rows([Row|Rest],N):-
    print_row(Row),
    (N mod 3=:=0->print_separator;true),
    N1 is N+1,
    print_rows(Rest,N1).


%funcion para imprimir la cuadricula
print_grid(Rows):-
    nl,
    print_separator,
    print_rows(Rows,1).

%busqueda de una segunda solucion:
unique_solution(Puzzle) :-
    sudoku(Puzzle),
    maplist(copy_term, Puzzle, PuzzleCopy),
    (   sudoku(PuzzleCopy),
        Puzzle \= PuzzleCopy
    ->  writeln('More than one solution.')
    ;   writeln('Unique solution.')
    ).
