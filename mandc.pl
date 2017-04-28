% Sree Narayan Chakraborty ASH1201002M
% CSTE7th Batch
% Session 2011-12
% NSTU

start([3,3,0,0,east]).
goal([0,0,3,3,west]).


legal(CL,ML,CR,MR) :-
	% is this state a legal one?
	ML>=0, CL>=0, MR>=0, CR>=0,
	(ML>=CL ; ML=0),
	(MR>=CR ; MR=0).

% Possible moves:
move([CL,ML,CR,MR,east],[CL,ML2,CR,MR2,west]):-
	% Two missionaries cross east to west.
	MR2 is MR+2,
	ML2 is ML-2,
	legal(CL,ML2,CR,MR2).

move([CL,ML,CR,MR,east],[CL2,ML,CR2,MR,west]):-
	% Two cannibals cross east to west.
	CR2 is CR+2,
	CL2 is CL-2,
	legal(CL2,ML,CR2,MR).

move([CL,ML,CR,MR,east],[CL2,ML2,CR2,MR2,west]):-
	%  One missionary and one cannibal cross east to west.
	CR2 is CR+1,
	CL2 is CL-1,
	MR2 is MR+1,
	ML2 is ML-1,
	legal(CL2,ML2,CR2,MR2).

move([CL,ML,CR,MR,east],[CL,ML2,CR,MR2,west]):-
	% One missionary crosses east to west.
	MR2 is MR+1,
	ML2 is ML-1,
	legal(CL,ML2,CR,MR2).

move([CL,ML,CR,MR,east],[CL2,ML,CR2,MR,west]):-
	% One cannibal crosses east to west.
	CR2 is CR+1,
	CL2 is CL-1,
	legal(CL2,ML,CR2,MR).

move([CL,ML,CR,MR,west],[CL,ML2,CR,MR2,east]):-
	% Two missionaries cross west to east.
	MR2 is MR-2,
	ML2 is ML+2,
	legal(CL,ML2,CR,MR2).

move([CL,ML,west,CR,MR],[CL2,ML,east,CR2,MR]):-
	% Two cannibals cross west to east.
	CR2 is CR-2,
	CL2 is CL+2,
	legal(CL2,ML,CR2,MR).

move([CL,ML,CR,MR,west],[CL2,ML2,CR2,MR2,east]):-
	%  One missionary and one cannibal cross west to east.
	CR2 is CR-1,
	CL2 is CL+1,
	MR2 is MR-1,
	ML2 is ML+1,
	legal(CL2,ML2,CR2,MR2).

move([CL,ML,CR,MR,west],[CL,ML2,CR,MR2,east]):-
	% One missionary crosses west to east.
	MR2 is MR-1,
	ML2 is ML+1,
	legal(CL,ML2,CR,MR2).

move([CL,ML,CR,MR,west],[CL2,ML,CR2,MR,east]):-
	% One cannibal crosses west to east.
	CR2 is CR-1,
	CL2 is CL+1,
	legal(CL2,ML,CR2,MR).


% Recursive call to solve the problem
path([CL1,ML1,CR1,MR1,B1],[CL2,ML2,CR2,MR2,B2],Explored,MovesList) :- 
   move([CL1,ML1,CR1,MR1,B1],[CL3,ML3,CR3,MR3,B3]), 
   not(member([CL3,ML3,CR3,MR3,B3],Explored)),
   path([CL3,ML3,CR3,MR3,B3],[CL2,ML2,CR2,MR2,B2],[[CL3,ML3,CR3,MR3,B3]|Explored],[ [[CL3,ML3,CR3,MR3,B3],[CL1,ML1,CR1,MR1,B1]] | MovesList ]).

% Solution found
path([CL,ML,CR,MR,B],[CL,ML,CR,MR,B],_,MovesList):- 
	output(MovesList).

% Printing
output([]) :- nl. 
output([[A,B]|MovesList]) :- 
	output(MovesList), 
   	write(B), write(' ------> '), write(A), nl,nl.

% Find the solution for the missionaries and cannibals problem
mandc([A,B,C,D,E],[P,Q,R,S,T]) :-
A=3,B=3,path([A,B,C,D,east],[P,Q,R,S,west],[[A,B,C,D,east]],_).