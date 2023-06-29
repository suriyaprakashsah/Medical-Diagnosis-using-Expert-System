
explainQuestion(age,'Many nephrological pathologies are characteristic of a certain age group.').
explainQuestion(hematuria,'Traces of blood in the urine is one of the first symptoms of kidney failure.').
explainQuestion(hexaurines,'Urinalysis is needed for a more thorough diagnosis.').
explainQuestion(bloodexaminer,'Blood tests are needed for a more thorough diagnosis.').
explainQuestion(proteinuria,'Proteinuria describes a condition in which there is an abnormal amount of protein in the urine.').
explainQuestion(azotemia,'azotemia is an indicator of proper kidney function.').
explainQuestion(creatinine,'Creatinine is an indicator of proper kidney function.').
explainQuestion(proteindiet,'A high blood urea nitrogen may be due to a high protein diet.').
explainQuestion(musclemass,'A high creatinine value may be due to an increase in muscle mass.').
explainQuestion(cholesterol,'High cholesterol affects the onset of kidney disease.').
explainQuestion(edema,'Widespread edema in the body are indicators of kidney disease.').
explainQuestion(ache,'Flank pain is the first indicator of kidney failure.').
explainQuestion(waterconsumption,'Consuming an adequate amount of water is essential for proper kidney function.').
explainQuestion(diarrea,'Diarrea can be a gastrointestinal symptom of renal insufficiency.').
explainQuestion(exposure,'Exposure to toxic substances can favor the onset of specific nephropathies.').
explainQuestion(drugs,"The use of drugs constitutes the patient's medical history.").
explainQuestion(drugabuse,'Drug abuse can favor the onset of specific nephropathies.').
explainQuestion(urinaryinfection,'A previously untreated urinary tract infection can lead to pyelonephritis').
explainQuestion(fever,'The febrile state may be associated with ongoing urinary infections.').
explainQuestion(burning,'Burning felt during urination may be due to urinary infections in progress.').
explainQuestion(urinationfrequency,'Frequent urination is a symptom of ongoing urinary tract infections.').
explainQuestion(urinatingdifficulty,'Urinary tract obstruction can be a symptom of ongoing infections.').
explainQuestion(inheritance,'Many kidney diseases can be inherited.').
explainQuestion(geneticdefects,'Many kidney diseases can be due to genetic defects.').
explainQuestion(hypertension,'Untreated high blood pressure can lead to kidney failure.').
explainQuestion(sodiumconsumption,'Sodium consumption could affect the state of hypertension.').


explain(Diagnosis,DiagCF) :-
    findall(Symp-CF,(rule _:[diagnosis(Diagnosis,_),symptom(Symp,_)] ==> _ with salience = _,fact(symptom(Symp,CF)),CF > 0),Symptoms),
    findall(Val-Meas,(rule _:[diagnosis(Diagnosis,_),value(Val,Meas),_] ==> _ with salience = _,fact(value(Val,Meas))),Measures),
    write('I arrived at the diagnosis '),
    upcase_atom(Diagnosis,Up),
    write(Up),
    write(' with certainity '),
    write(DiagCF),
    write(' because I found:'),
    nl,
    showExplain(Symptoms),
    showExams(Measures).


showExplain([]) :- !.
showExplain([Sympt-CF|Rest]) :-
    write('  --> '),
    write(Sympt),
    write(' with certainity '),
    write(CF),
    nl,
    showExplain(Rest).


showExams([]) :- !.
showExams([Val-Meas|Rest]) :-
    write('  --> '),
    write(Val),
    write(' with value '),
    write(Meas),
    nl,
    showExams(Rest).

