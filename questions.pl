question([0,21,22],age,doctor,'Enter patient age').
question([0,21,22],age,patient,'Enter your age').

question([1],hematuria,doctor,'The patient has hematuria?').
question([1],hematuria,patient,'Evident traces of blood are visible in the urine?').

question([2],hexaurines,_,'Urine tests are available?').
question([3],bloodexaminer,_,'Blood tests are available?').

question([4],proteinuria,doctor,'Enter proteinuria value (mg/day):').
question([5,6],azotemia,doctor,'Enter blood urea nitrogen value (mg/dl):').
question([8,9],creatinine,doctor,'Enter creatinine value (mg/dl):').
question([6,7],proteindiet,doctor,'The patient follows a diet rich in proteins?').
question([9,10],musclemass,doctor,'The patient has muscle hypertrophy?').

question([11],cholesterol,doctor,'The patient has hypercholesterolemia?').
question([11],cholesterol,patient,'You have high cholesterol?').

question([12],edema,doctor,'The patient has edema?').
question([12],edema,patient,'You experience swelling in your legs or other parts of your body?').

question([13],ache,doctor,'The patient feels pain in the hips?').
question([13],ache,patient,'You feel pain in your hips?').

question([14,16,17],waterconsumption,doctor,'How many glasses of water does the patient consume per day?').
question([14,16,17],waterconsumption,patient,'How many glasses of water do you consume per day?').

question([15,16,17],diarrea,doctor,'The patient has recently had problems with diarrhea?').
question([15,16,17],diarrea,patient,'You have recently had problems with diarrhea?').

question([18],exposure,doctor,'The patient has been exposed to toxic substances?').
question([18],exposure,patient,'You have been exposed to toxic substances?').

question([19,20],drugs,doctor,'The patient has recently taken medication?').
question([19,20],drugs,patient,'You have taken any medications recently?').

question([20],drugabuse,doctor,'The patient has abused nephrotoxic drugs?').
question([20],drugabuse,patient,'You have abused antibiotics/painkillers?').

question([21],urinaryinfection,doctor,'The patient has had or suffers from urinary tract infections in the past?').
question([21],urinaryinfection,patient,'You have suffered in the past or suffer from urinary tract infections?').

question([23],fever,doctor,'The patient has a fever?').
question([23],fever,patient,'Have you got a fever?').

question([24],burning,doctor,'The patient suffers from dysuria?').
question([24],burning,patient,'You feel burning while you urinate?').

question([25],urinationfrequency,doctor,'How often does urination occur? (number of times)').
question([25],urinationfrequency,patient,'How many times a day do you urinate?').

question([26],urinatingdifficulty,doctor,'The patient experiences obstruction during urination?').
question([26],urinatingdifficulty,patient,'You have difficulty urinating?').

question([27],inheritance,doctor,'The patient has had cases in the family of nephrological pathologies?').
question([27],inheritance,patient,'Have you had relatives who suffered from kidney disease?').

question([28],geneticdefects,doctor,'The patient suffers from genetic malformations in the kidney?').
question([28],geneticdefects,patient,'You have genetic malformations at the level of the kidneys?').

question([29,30,31],hypertension,doctor,'The patient suffers from hypertension?').
question([29,30,31],hypertension,patient,'You suffer from hypertension?').

question([30,31],sodiumconsumption,doctor,'The patient follows a diet rich in sodium?').
question([30,31],sodiumconsumption,patient,'Follow a diet rich in salty foods?').


getAllQuestions :-
    fact(mode(Mode)),
    forall(question([ID|_],Question,Mode,_),(write('Question '),write(ID),write(':'),write(Question),nl)),
    !.


getAssociatedRules(Question,Rules) :-
    question(Rules,Question,_,_),
    !.


getQuestion(Question,Mode,Text) :-
    question(_,Question,Mode,Text),
    !.



