createFileName(Filename) :-
     get_time(T),
     stamp_date_time(T,Date,'UTC'),
     arg(1,Date,Year),
     arg(2,Date,Month),
     arg(3,Date,Day),
     arg(4,Date,Hour),
     arg(5,Date,Minute),
     atomic_list_concat(['Diagnosis_',Year,Month,Day,Hour,Minute,'.txt'],Filename).


writeResultsOnFile(Filename) :-
     open(Filename,write,Stream),
     write(Stream,'===================================='),
     nl(Stream),
     write(Stream,'Results Medical Diagnosis'),
     nl(Stream),
     fact(mode(Mode)),
     write(Stream,'===================================='),
     nl(Stream),
     nl(Stream),
     write(Stream,'System run in mode '),
     write(Stream,Mode),
     nl(Stream),
     nl(Stream),
     write(Stream,'Diagnosis achieved'),
     nl(Stream),
     nl(Stream),
     writeDiagnosisOnFile(Stream),
     close(Stream).


writeDiagnosisOnFile(Stream) :-
    findall(Diag-CF,(fact(diagnosis(Diag,CF)), CF > 0.0),Diagnosis),
    sortDiagnosis(Diagnosis,Sorted),
    forall(member(Diag-CF,Sorted),
	   (upcase_atom(Diag,Up),write(Stream,Up),write(Stream,' with certainity '),write(Stream,CF),
	    write(Stream,'. Symptoms encountered'),nl(Stream),writeSymptomsOnFile(Stream,Diag))).


writeSymptomsOnFile(Stream,Diag) :-
    findall(Symp-CF,(rule _:[diagnosis(Diag,_),symptom(Symp,_)] ==> _ with salience = _,fact(symptom(Symp,CF)),CF > 0),Symptoms),
    findall(Val-Meas,(rule _:[diagnosis(Diag,_),value(Val,Meas),_] ==> _ with salience = _,fact(value(Val,Meas))),Measures),
    forall(member(Symp-CF,Symptoms),(write(Stream,' -'),write(Stream,Symp),write(Stream,' certainity '),write(Stream,CF),nl(Stream))),
    forall(member(Val-Meas,Measures),(write(Stream,' -'),write(Stream,Val),write(Stream,' value '),write(Stream,Meas),nl(Stream))),
    nl(Stream).
    
