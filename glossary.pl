concept('azotemia','It is the rate of the amount of nitrogen in the blood and accurately indicates the functionality of the kidneys; values ​​different from the reference ones indicate an imperfect purification of the blood by the kidneys. Values ​​of 10-45 mg/dl are considered normal').

concept('cholesterol','It is a molecule of the sterol family responsible for various tasks in the body, mainly during the synthesis of essential components for digestion'). 

concept('creatinine','It is a blood component that is eliminated in the urine; signals the functionality of the kidney as it is eliminated by the kidneys themselves through the urine. Values ​​of 0-1 mg/dl are considered normal').

concept('hematuria','Hemautria is defined as the presence of blood in the urine').

concept('edema','Edema is swelling resulting from the accumulation of fluid in the interstitial spaces of the body').

concept('glomerulus','The renal glomerulus is a dense spheroidal network of arterial capillaries, responsible for blood filtration.').

concept('glomerulonephritis','Glomerulonephritis is an inflammation that affects the kidneys and in particular the renal glomeruli, compromising the filtering capacity of the organ itself').

concept('kidney failure','Renal insufficiency represents the impossibility of the kidney to carry out its natural filtering function. It can be acute if it appears abruptly or chronic if its course is slow and gradual').

concept('hypertension','Hypertension is a clinical condition in which the blood pressure in the arteries is above the normal values ​​of 110/80').

concept('interstitial nephropathy','Interstitial nephropathy is acute renal failure primarily affecting the renal tubules and interstitial tissue.').

concept('pelvis','The renal pelvis represents the anatomical entity that receives urine and conveys it into the ureter').

concept('pyelonephritis','Pyelonephritis is an acute or chronic inflammatory disease of the kidney and renal pelvis.').

concept('proteinuria','It is the amount of protein in the urine. The kidneys should not let the proteins pass in the urine (they are blocked first) as they are very important substances for the body and cannot be disposed of. Normal values ​​up to 500 mg').

concept('polycystic kidney','Polycystic kidney disease is a genetic disease in which normal kidney tissue is replaced by numerous cysts.').

concept('nephrotic syndrome','Nephrotic syndrome is a disease caused by an alteration of the renal glomeruli which leads to a loss of protein in the urine'). 

concept('renal tubule','The tubule has the function of modifying, through processes of reabsorption and secretion, the composition of the ultrafiltrate produced by the glomerulus').


glossary :-
    forall(concept(Conc,Mean),(nl,upcase_atom(Conc,Up),write(Up),write(':'),write(Mean),nl)).
