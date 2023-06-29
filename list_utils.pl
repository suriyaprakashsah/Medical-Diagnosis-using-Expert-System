difference(L,[],L).
difference(L1,[H|L2],L3) :-
    not(member(H,L1)),
    difference(L1,L2,L3).


difference(L1,[H|L2],L3) :-
    member(H,L1),
    nth0(_,L1,H,L4),
    difference(L4,L2,L3).


extractSubList([],_,[]) :- !.
extractSubList([Item|_],Item,[Item]) :- !.
extractSubList([ItemX|Rest],Item,ListOut) :-
    extractSubList(Rest,Item,ListOutX),
    append([ItemX],ListOutX,ListOut),
    !.


insertRule(RuleID-Salience,[],[RuleID-Salience]) :- !.
insertRule(RuleID-Salience,[RuleIDX-SalienceX|Rest],[RuleID-Salience,RuleIDX-SalienceX|Rest]) :-
    Salience < SalienceX,
    !.


insertRule(RuleID-Salience,[RuleIDX-Salience|Rest],[RuleID-Salience,RuleIDX-Salience|Rest]) :-
    RuleID < RuleIDX,
    !.


insertRule(RuleID-Salience,[RuleIDX-SalienceX|Rest],[RuleIDX-SalienceX|Others]) :-
    insertRule(RuleID-Salience,Rest,Others).


memberRule(RuleID, [RuleID-_|_]) :- !.
memberRule(RuleID, [_-_|Rest]) :-
    memberRule(RuleID,Rest).


sortDiagnosis([],[]).
sortDiagnosis([Diag-CF|Rest],Sorted) :-
    partition(Rest,CF,Left,Right),
    sortDiagnosis(Left,LeftS),
    sortDiagnosis(Right,RightS),
    append(LeftS,[Diag-CF|RightS],Sorted).


partition([DiagX-CFX|Rest],CF,[DiagX-CFX|Ls],Rs) :-
    CFX > CF,
    partition(Rest,CF,Ls,Rs).


partition([],_,[],[]).
partition([DiagX-CFX|Rest],CF,Ls,[DiagX-CFX|Rs]) :-
    CFX =< CF,
    partition(Rest,CF,Ls,Rs).

    








  
