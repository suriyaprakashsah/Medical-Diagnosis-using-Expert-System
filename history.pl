:- dynamic recovery/2.


recoverState([]) :- !.
recoverState([Rule|Rules]) :-
    undoRule(Rule),
    recoverState(Rules).


saveAction(RuleID,assert(X)) :-
    retract(recovery(RuleID,Hist)),
    assert(recovery(RuleID,[retract(fact(X))|Hist])),
    !.


saveAction(RuleID,assert(X)) :-
    assert(recovery(RuleID,[retract(fact(X))])),
    !.


saveAction(RuleID,asserta(X)) :-
    retract(recovery(RuleID,Hist)),
    assert(recovery(RuleID,[retract(fact(X))|Hist])),
    !.


saveAction(RuleID,asserta(X)) :-
    assert(recovery(RuleID,[retract(fact(X))])),
    !.


saveAction(RuleID,assertz(X)) :-
    retract(recovery(RuleID,Hist)),
    assert(recovery(RuleID,[retract(fact(X))|Hist])),
    !.


saveAction(RuleID,assertz(X)) :-
    assert(recovery(RuleID,[retract(fact(X))])),
    !.


saveAction(RuleID,retract(X)) :-
    retract(recovery(RuleID,Hist)),
    assert(recovery(RuleID,[assert(fact(X))|Hist])),
    !.


saveAction(RuleID,retract(X)) :-
    assert(recovery(RuleID,[assert(fact(X))])),
    !.


saveAction(_,_) :- !.


undoRule(Rule) :-
    %I retrieve the actions to undo
    retract(recovery(Rule,Actions)),
    forall(member(Action,Actions),Action).
