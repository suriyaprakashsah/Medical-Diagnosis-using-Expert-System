:- ensure_loaded(knowledge).
:- ensure_loaded(explanation).
:- ensure_loaded(history).
:- ensure_loaded(list_utils).
:- ensure_loaded(questions).
:- ensure_loaded(uncertainty).
:- ensure_loaded(file_utils).
:- ensure_loaded(glossary).

:- dynamic open/1.
:- dynamic closed/1.


open([]).
closed([]).


% Engine core
% --------
run :-
	conflictSet,
	getFirstRule(RuleID-Sal),
	fire(RuleID-Sal),
	setClosedRule(RuleID),
	!,
	run.


run :-
    findall(Diag,fact(diagnosis(Diag,0.0)), Diagnosis),
    length(Diagnosis,6),
    write('I could not find a diagnosis '),
    nl,
    reExecute,
    !.


run :-
    getStatus,
    reExecute,
    !.


activable(RuleID) :-
	closed(L),
	not(member(RuleID,L)).


conflictSet :-
    findall(ID-Sal,(call(rule ID:LHS ==> _ with salience = Sal),activable(ID),not(ready(ID)),matchConditions(LHS)),Rules),
    updateOpen(Rules).
        

findFact([]) :- !.
findFact([LHSFst|LHSRest]) :-
    fact(LHSFst),
    findFact(LHSRest).


findFact([_|LHSRest]) :-
    findFact(LHSRest),
    !.


fire(RuleID-Sal) :-
	call(rule RuleID: LHS ==> RHS with salience = Sal),
	findFact(LHS),     
	process(RuleID,RHS).    


getFirstRule(RuleID-Sal) :-
	retract(open([RuleID-Sal|Rest])),
	assert(open(Rest)).


getStatus :-
     write('The system is running in mode '),
     fact(mode(Mode)),
     write(Mode),
     nl,
     write('I arrived at the following diagnosis:'),
     nl,
     findall(Diag-CF,(fact(diagnosis(Diag,CF)), CF > 0.0),Diagnosis),
     sortDiagnosis(Diagnosis,Sorted),
     forall((member(D-C,Sorted),C > 0),explain(D,C)).


matchConditions([]) :- !.
matchConditions([Fst|Rest]) :-
	(fact(Fst);
	 test(Fst)),
	matchConditions(Rest),
	!.


modifyAnswer(Quest) :-
    (fact(symptom(Quest,Val)) ; fact(value(Quest,Val))),
    write('Previous answer: '),
    getUncertainity(Ans,Val),
    write(Ans),
    nl,
    retract(closed(Closed)),
    retract(open(_)),
    getAssociatedRules(Quest,AssociatedRules),
    findall(RuleID,(member(RuleID,Closed),member(RuleID,AssociatedRules)),Rules),
    findall(DiagID,(member(DiagID,Closed),DiagID >= 100, DiagID < 999),DiagRules),
    recoverState(Rules),         
    recoverState(DiagRules),
    difference(Closed,Rules,TempClosed),
    difference(TempClosed,DiagRules,UpdatedClosed),
    assert(closed(UpdatedClosed)),
    assert(open([])),
    run,
    !.


modifyFlow(Answ) :-
    retract(closed(Closed)),
    retract(open(_)),
    question([ID|_],Answ,_,_),
    extractSubList(Closed,ID,NewClosed),
    recoverState(NewClosed),
    difference(Closed,NewClosed,UpdatedClosed),
    assert(closed(UpdatedClosed)),
    assert(open([])),
    !.

process(_,[]) :- !.
process(RuleID,[Action|Rest]) :-
	take(Action),
	saveAction(RuleID,Action),   
	process(RuleID,Rest).
	

ready(RuleID) :-
	open(L),
	memberRule(RuleID,L).


reExecute :- 
    write('Do you want to restart the system from a specific question or change an answer given? (questionlist/glossarylist/edit/startagain/stop)'),
    nl,
    read(X),
    (
    X == glossarylist,
    glossary,
    reExecute
    ;
    X == questionlist,
    getAllQuestions,
    reExecute
    ;
    X == startagain,
    write('Which question do you want to start with?'),
    read(Quest),
    nl,
    modifyFlow(Quest),
    run
    ;
    X == edit,
    write('Which answer do you want to edit?'),
    read(Quest),
    nl,
    modifyAnswer(Quest),
    run
    ;
    X == stop,
    createFileName(Filename),
    writeResultsOnFile(Filename),
    write('Good Bye...'),
    nl,
    fail
    ).


setClosedRule(RuleID) :-
	retract(closed(Rules)),
	assert(closed([RuleID|Rules])).


take(assert(X)) :-
	assert(fact(X)),
	!.


take(asserta(X)) :-
	asserta(fact(X)),
	!.


take(assertz(X)) :-
	assertz(fact(X)),
	!.


take(retract(X)) :-
	retract(fact(X)),
	!.
    

take(reloadall(X)) :-
	retract(open(_)),
	retract(closed(_)),
	assert(open([])),
	assert(closed([])),
	abolish(fact/1),
	reconsult(X).


take(getUncertainity(X,Val)) :-
    getUncertainity(X,Val).


take(computeCFCombination(Prev,CF,CH)) :-
    computeCFCombination(Prev,CF,CH).


take(print(X)) :-
	write(X),
	nl,
	!.


take(printQuestion(X)) :-
	fact(mode(Mode)),
	question(_,X,Mode,Text),
	write(Text),
	nl,
	!.


take(printQuestion(X,multiple)) :-
	fact(mode(Mode)),
	question(_,X,Mode,Text),
	write(Text),
	write(' (no/certainlynot/probablynot/maybenot/dontknow/maybe/probably/certainly/yes) '),
	nl,
	!.


take(read(X)) :-
    read(X),
    nl,
    !.  


take(readInput(Question,Answer,multiple)) :-
    fact(mode(Mode)),
    getQuestion(Question,Mode,Text),
    write(Text),
    write(' (no/certainlynot/probablynot/maybenot/dontknow/maybe/probably/certainly/yes) '),
    read(X),
    (
    X == glossarylist,
    glossary,
    take(readInput(Question,Answer,multiple))
    ;
    X == state,
    getStatus,
    take(readInput(Question,Answer,multiple))
    ;
    X \= why, X \= state, X \= glossarylist,
    nl,
    Answer = X,
    findall(Nas, certainity(Nas, _), Rslt),
    (member(Answer,Rslt) 
    ;
    not(member(Answer,Rslt)),
    write('You have chosen the wrong options..!'),nl,
    write('Kindly select a option from this (no/certainlynot/probablynot/maybenot/dontknow/maybe/probably/certainly/yes)'),nl,
    run,
    !
    )
    ;
    X == why,
    explainQuestion(Question,Expl),
    write(Expl),
    nl,
    take(readInput(Question,Answer,multiple))
    ).


take(readInput(Question,Answer)) :-
    fact(mode(Mode)),
    getQuestion(Question,Mode,Text),
    write(Text),
    write(' (no/dontknow/yes)'),
    read(X),
    (
    X == glossarylist,
    glossary,
    take(readInput(Question,Answer))
    ;
    X == state,
    getStatus,
    take(readInput(Question,Answer))
    ;
    X \= why, X \= state, X \= glossarylist,
    nl,
    Answer = X,
    (member(Answer, ['no', 'dontknow', 'yes']) 
    ;
    not(member(Answer, ['no', 'dontknow', 'yes'])),
    write('You have chosen the wrong options..!'),nl,
    write('Kindly select a option from this (no/dontknow/yes)'),nl,
    run,
    !
    )
    ;
    X == why,
    explainQuestion(Question,Expl),
    write(Expl),
    nl,
    take(readInput(Question,Answer))
    ).


take(readInput(Question,Answer,number)) :-
    fact(mode(Mode)),
    getQuestion(Question,Mode,Text),
    write(Text),
    write(' (dontknow)'),
    read(X),
    (
    X == glossarylist,
    glossary,
    take(readInput(Question,Answer,number))
    ;
    X == state,
    getStatus,
    take(readInput(Question,Answer,number))
    ;
    X \= why, X == dontknow,
    nl,
    Answer = 0
    ;
    X \= why, X \= dontknow, X \= state, X \= glossarylist,
    nl,
    Answer = X,
    (integer(Answer),
    (Answer < 150;
    write('Kindly provide valid age..!'),
    nl,
    run, 
    !)
    ;
    not(integer(Answer)),
    write('Kindly provide integer values..!'),nl,
    run,
    !
    )
    ;
    X == why,
    explainQuestion(Question,Expl),
    write(Expl),
    nl,
    take(readInput(Question,Answer,number))
    ).     


% Arithmetic operators
% --------
take(sum(X,Y,Z)) :-
    Z is X + Y,
    !.


take(diff(X,Y,Z)) :-
    Z is X - Y,
    !.


take(mul(X,Y,Z)) :-
    Z is X * Y,
    !.


take(div(X,Y,Z)) :-
    Z is X / Y,
    !.


test(not(X)) :-
    not(fact(X)),
    !.


% Boolean tests
% --------
test(X < Y) :-
	X < Y,
	!.


test(X > Y) :-
	X > Y,
	!.


test(X >= Y) :-
    X >= Y,
    !.


test(X =< Y) :-
    X =< Y,
    !.


test(X == Y) :-
	X == Y,
	!.


updateOpen(Rules) :-
        forall(member(ID-Sal,Rules),(retract(open(Old)),insertRule(ID-Sal,Old,New),assert(open(New)))).
