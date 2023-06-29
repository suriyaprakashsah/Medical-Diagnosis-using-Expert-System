
certainity(no,-1.0).
certainity(certainlynot,-0.8).
certainity(probablynot,-0.6).
certainity(maybenot,-0.4).
certainity(dontknow,0).
certainity(maybe,0.4).
certainity(probably,0.6).
certainity(certainly,0.8).
certainity(yes,1.0).


getUncertainity(Label,Value) :-
    certainity(Label,Value).


computeCFAndConditions(Factors,RuleCF,CH) :-
    min_list(Factors,Min),
    CH is RuleCF * Min.


computeCFOrConditions(Factors,RuleCF,CH) :-
    max_list(Factors,Max),
    CH is RuleCF * Max.


computeCFCombination(Previous,RuleCF,CH) :-
    Temp is 1 - Previous,
    CH is Previous + RuleCF * Temp.
