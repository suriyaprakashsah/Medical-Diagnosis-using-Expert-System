:- op(230, xfx, ==>).
:- op(32, xfy, :).
:- op(250, fx, rule).
:- op(400, xfy, with).
:- op(400, xfy, salience).
:- op(400, xfy, =).

:- dynamic fact/1.


%% Initialize system
rule 2000:
[]
==>
[print('Welcome to Medical Diagnosis, the expert system for diagnosing nephropathies'),
 print('During execution, type status or why for help. Type glossary to get information about unfamiliar terms'),
 assert(diagnosis('kidney failure',0.0)),
 assert(diagnosis('nephrotic syndrome',0.0)),
 assert(diagnosis('polycystic kidney',0.0)),
 assert(diagnosis(pyelonephritis,0.0)),
 assert(diagnosis(glomerulonephritis,0.0)),
 assert(diagnosis('interstitial nephropathy',0.0))
]
with salience = -200.


rule 1000:
[]
==>
[print('Is the user a doctor or a patient?'),read(X),assert(mode(X))]
with salience = -100.


rule 0:
[]
==>
[readInput(age,X,number),assert(age(X))]
with salience = 10.


rule 1:
[]
==>
[readInput(hematuria,X,multiple),getUncertainity(X,Val),assert(symptom(hematuria,Val))]
with salience = 10.


rule 2:
[mode(doctor)]
==>
[readInput(hexaurines,X),assert(hexaurines(X))]
with salience = 10.


rule 3:
[mode(doctor)]
==>
[readInput(bloodexaminer,X),assert(bloodexaminer(X))]
with salience = 10.


rule 4:
[mode(doctor),hexaurines(yes)]
==>
[readInput(proteinuria,X,number),assert(value(proteinuria,X))]
with salience = 5.


rule 5:
[mode(doctor),bloodexaminer(yes)]
==>
[readInput(azotemia,X,number),assert(value(azotemia,X))]
with salience = 5.


rule 6:
[value(azotemia,A), A > 45]
==>
[readInput(proteindiet,X,multiple),getUncertainity(X,Val),assert(proteindiet(Val))]
with salience = 0.


rule 7:
[proteindiet(Val),Val > 0.6]
==>
[retract(value(azotemia,_)),assert(value(azotemia,0.2))]
with salience = 0.


rule 8:
[mode(doctor),bloodexaminer(yes)]
==>
[readInput(creatinine,X,number),assert(value(creatinine,X))]
with salience = 5.


rule 9:
[value(creatinine,C), C > 1]
==>
[readInput(musclemass,X,multiple),getUncertainity(X,Val),assert(musclemass(Val))]
with salience = 0.


rule 10:
[musclemass(Val),Val > 0.6]
==>
[retract(value(creatinine,_)),assert(value(creatinine,0.2))]
with salience = 0.


rule 11:
[]
==>
[readInput(cholesterol,X,multiple),getUncertainity(X,Val),assert(symptom(cholesterol,Val))]
with salience = 10.


rule 12:
[]
==>
[readInput(edema,X,multiple),getUncertainity(X,Val),assert(symptom(edema,Val))]
with salience = 10.


rule 13:
[]
==>
[readInput(ache,X,multiple),getUncertainity(X,Val),assert(symptom(ache,Val))]
with salience = 10.


rule 14:
[]
==>
[readInput(waterconsumption,X,number),assert(waterconsumption(X))]
with salience = 10.


rule 15:
[]
==>
[readInput(diarrea,X,multiple),getUncertainity(X,Val),assert(symptom(diarrea,Val))]
with salience = 10.


rule 16:
[waterconsumption(X), X < 9, symptom(diarrea,Val), Val > 0.6]
==>
[diff(8.1,X,H),div(H,8.1,CF),assert(symptom(dehydration,CF))]
with salience = 5.


rule 17:
[waterconsumption(X), X < 9, symptom(diarrea,Val), Val =< 0.6]
==>
[diff(8.1,X,H),div(H,8.1,CF),mul(CF,0.7,CF1),assert(symptom(dehydration,CF1))]
with salience = 5.


rule 18:
[]
==>
[readInput(exposure,X,multiple),getUncertainity(X,Val),assert(symptom(exposure,Val))]
with salience = 10.


rule 19:
[]
==>
[readInput(drugs,X),assert(drugs(X))]
with salience = 10.


rule 20:
[drugs(yes)]
==>
[readInput(drugabuse,X,multiple),getUncertainity(X,Val),assert(symptom(drugabuse,Val))]
with salience = 5.


rule 21:
[age(E),E > 18]
==>
[readInput(urinaryinfection,X,multiple),getUncertainity(X,Val),assert(symptom(urinaryinfection,Val))]
with salience = 15.


rule 22:
[symptom(urinaryinfection,CF), CF > 0, age(E), E < 12]
==>
[retract(symptom(urinaryinfection,CF)),diff(CF,0.2,CH),assert(symptom(urinaryinfection,CH))]
with salience = 5.


rule 23:
[symptom(urinaryinfection,_)]
==>
[readInput(fever,X,multiple),getUncertainity(X,Val),assert(symptom(fever,Val))]
with salience = 5.


rule 24:
[]
==>
[readInput(burning,X,multiple),getUncertainity(X,Val),assert(symptom(burning,Val))]
with salience = 15.


rule 25:
[]
==>
[readInput(urinationfrequency,X,number),assert(symptom(urinationfrequency,X))]
with salience = 15.


rule 26:
[]
==>
[readInput(urinatingdifficulty,X,multiple),getUncertainity(X,Val),assert(symptom(urinatingdifficulty,Val))]
with salience = 15.


rule 27:
[]
==>
[readInput(inheritance,X,multiple),getUncertainity(X,Val),assert(symptom(inheritance,Val))]
with salience = 15.


rule 28:
[]
==>
[readInput(geneticdefects,X,multiple),getUncertainity(X,Val),assert(symptom(geneticdefects,Val))]
with salience = 15.


rule 29:
[]
==>
[readInput(hypertension,X,multiple),getUncertainity(X,Val),assert(symptom(hypertension,Val))]
with salience = 15.


rule 30:
[symptom(hypertension,_)]
==>
[readInput(sodiumconsumption,X),assert(sodiumconsumption(X))]
with salience = 5.


rule 31:
[symptom(hypertension,I), I < 1, sodiumconsumption(yes)]
==>
[retract(symptom(hypertension,I)),sum(I,0.2,CF),assert(symptom(hypertension,CF))]
with salience = 5.



%% Glomerulonephritis start
rule 100:
[diagnosis(glomerulonephritis,Previous),symptom(cholesterol,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(glomerulonephritis,_)),assert(diagnosis(glomerulonephritis,CH))]
with salience = 0.


rule 101:
[diagnosis(glomerulonephritis,Previous),symptom(hematuria,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(glomerulonephritis,_)),assert(diagnosis(glomerulonephritis,CH))]
with salience = 0.


rule 102:
[diagnosis(glomerulonephritis,Previous),value(proteinuria,P),P > 3500]
==>
[computeCFCombination(Previous,0.9,CH),retract(diagnosis(glomerulonephritis,_)),assert(diagnosis(glomerulonephritis,CH))]
with salience = 0.


rule 103:
[diagnosis(glomerulonephritis,Previous),symptom(edema,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(glomerulonephritis,_)),assert(diagnosis(glomerulonephritis,CH))]
with salience = 0.


rule 104:
[diagnosis(glomerulonephritis,Previous),symptom(brucioreminzione,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(glomerulonephritis,_)),assert(diagnosis(glomerulonephritis,CH))]
with salience = 0.


rule 105:
[diagnosis(glomerulonephritis,Previous),symptom(urinationfrequency,N), N > 10]
==>
[computeCFCombination(Previous,0.8,CH),retract(diagnosis(glomerulonephritis,_)),assert(diagnosis(glomerulonephritis,CH))]
with salience = 0.


rule 106:
[diagnosis(glomerulonephritis,Previous),symptom(urinatingdifficulty,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(glomerulonephritis,_)),assert(diagnosis(glomerulonephritis,CH))]
with salience = 0.


rule 107:
[diagnosis(glomerulonephritis,Previous),symptom(hypertension,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(glomerulonephritis,_)),assert(diagnosis(glomerulonephritis,CH))]
with salience = 0.
%% Glomerulonephritis end



%% Nephrotic Syndrome start
rule 200:
[diagnosis('nephrotic syndrome',Previous),symptom(cholesterol,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('nephrotic syndrome',_)),assert(diagnosis('nephrotic syndrome',CH))]
with salience = 0.


rule 201:
[diagnosis('nephrotic syndrome',Previous),symptom(hematuria,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('nephrotic syndrome',_)),assert(diagnosis('nephrotic syndrome',CH))]
with salience = 0.


rule 202:
[diagnosis('nephrotic syndrome',Previous),value(proteinuria,P),P > 3500]
==>
[computeCFCombination(Previous,0.9,CH),retract(diagnosis('nephrotic syndrome',_)),assert(diagnosis('nephrotic syndrome',CH))]
with salience = 0.


rule 203:
[diagnosis('nephrotic syndrome',Previous),symptom(edema,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('nephrotic syndrome',_)),assert(diagnosis('nephrotic syndrome',CH))]
with salience = 0.
%% Nephrotic Syndrome end



%% Kidney Failure start
rule 300:
[diagnosis('kidney failure',Previous),symptom(ache,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('kidney failure',_)),assert(diagnosis('kidney failure',CH))]
with salience = 0.


rule 301:
[diagnosis('kidney failure',Previous),symptom(hematuria,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('kidney failure',_)),assert(diagnosis('kidney failure',CH))]
with salience = 0.


rule 302:
[diagnosis('kidney failure',Previous),value(proteinuria,P), P > 3500]
==>
[computeCFCombination(Previous,0.9,CH),retract(diagnosis('kidney failure',_)),assert(diagnosis('kidney failure',CH))]
with salience = 0.


rule 303:
[diagnosis('kidney failure',Previous),symptom(dehydration,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('kidney failure',_)),assert(diagnosis('kidney failure',CH))]
with salience = 0.


rule 304:
[diagnosis('kidney failure',Previous),value(azotemia,A),A > 65]
==>
[computeCFCombination(Previous,0.8,CH),retract(diagnosis('kidney failure',_)),assert(diagnosis('kidney failure',CH))]
with salience = 0.


rule 305:
[diagnosis('kidney failure',Previous),value(creatinine,C),C > 1]
==>
[computeCFCombination(Previous,0.8,CH),retract(diagnosis('kidney failure',_)),assert(diagnosis('kidney failure',CH))]
with salience = 0.
%% Kidney Failure end



%% Interstitial Nephropathy start
rule 400:
[diagnosis('interstitial nephropathy',Previous),symptom(exposure,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('interstitial nephropathy',_)),assert(diagnosis('interstitial nephropathy',CH))]
with salience = 0.


rule 401:
[diagnosis('interstitial nephropathy',Previous),symptom(drugabuse,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('interstitial nephropathy',_)),assert(diagnosis('interstitial nephropathy',CH))]
with salience = 0.
%% Interstitial Nephropathy end



%% Polycystic Kidney start
rule 500:
[diagnosis('polycystic kidney',Previous),symptom(geneticdefects,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('polycystic kidney',_)),assert(diagnosis('polycystic kidney',CH))]
with salience = 0.


rule 501:
[diagnosis('polycystic kidney',Previous),symptom(inheritance,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('polycystic kidney',_)),assert(diagnosis('polycystic kidney',CH))]
with salience = 0.


rule 502:
[diagnosis('polycystic kidney',Previous),symptom(urinaryinfection,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis('polycystic kidney',_)),assert(diagnosis('polycystic kidney',CH))]
with salience = 0.
%% Polycystic kidney end



%% Pyelonephritis start
rule 600:
[diagnosis(pyelonephritis,Previous),symptom(fever,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(pyelonephritis,_)),assert(diagnosis(pyelonephritis,CH))]
with salience = 0.


rule 601:
[diagnosis(pyelonephritis,Previous),symptom(geneticdefects,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(pyelonephritis,_)),assert(diagnosis(pyelonephritis,CH))]
with salience = 0.


rule 602:
[diagnosis(pyelonephritis,Previous),symptom(burning,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(pyelonephritis,_)),assert(diagnosis(pyelonephritis,CH))]
with salience = 0.


rule 603:
[diagnosis(pyelonephritis,Previous),symptom(urinatingdifficulty,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(pyelonephritis,_)),assert(diagnosis(pyelonephritis,CH))]
with salience = 0.


rule 604:
[diagnosis(pyelonephritis,Previous),symptom(urinaryinfection,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(pyelonephritis,_)),assert(diagnosis(pyelonephritis,CH))]
with salience = 0.


rule 605:
[diagnosis(pyelonephritis,Previous),symptom(ache,CF)]
==>
[computeCFCombination(Previous,CF,CH),retract(diagnosis(pyelonephritis,_)),assert(diagnosis(pyelonephritis,CH))]
with salience = 0.
%% Pyelonephritis end