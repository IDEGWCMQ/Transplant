
use Dataset
summ Age if Exposure==0, detail
summ Age if Exposure==1, detail
ttest Age, by(Exposure)
gen AgeCat=1 if Age<30
replace AgeCat=2 if (Age>=30 & Age<40) 
replace AgeCat=3 if (Age>=40 & Age<50) 
replace AgeCat=4 if (Age>=50 & Age<60) 
replace AgeCat=5 if (Age>=60 & Age<70) 
replace AgeCat=6 if (Age>=70) 
label define AgeCat 1"<30" 2"30-39" 3"40-49" 4"50-59" 5"60-69" 6"70+"
label values AgeCat AgeCat
tab AgeCat Exposure, col chi2
tab Sex Exposure, col chi2
tab Natr Exposure, col chi2
gen Natr2=1 if (Natr==2 | Natr==3 | Natr==4 | Natr==5 | Natr==7)
replace Natr2=2 if (Natr==1 | Natr==6 | Natr==8 | Natr==9)
replace Natr2=3 if Natr==10
label define Natr2 1"Worker pop" 2"Urban pop" 3"Qatari"
label values Natr2 Natr2
gen transplantyear=year(DiagnosisDate)
gen yearssincetransplant=2021-transplantyear
summ yearssincetransplant if Exposure==0, detail
summ yearssincetransplant if Exposure==1, detail
ttest yearssincetransplant, by(Exposure)
gen yearstransplantCat=1 if yearssincetransplant<3
replace yearstransplantCat=2 if (yearssincetransplant>=3 & yearssincetransplant<=6)
replace yearstransplantCat=3 if (yearssincetransplant>=7 & yearssincetransplant<=11)
replace yearstransplantCat=4 if (yearssincetransplant>=12)
label define yearstransplantCat 1"<3 years" 2"3-6 years" 3"7-11 years" 4">=12 years"
label values yearstransplantCat yearstransplantCat
tab yearstransplantCat Exposure, col chi2
tab AZA Exposure, col chi2
tab Cyclosporine Exposure, col chi2
tab Everolimus Exposure, col chi2
tab MMF Exposure, col chi2
tab Prednisolone Exposure, col chi2
tab Sirolimus Exposure, col chi2
tab Tacrolimus Exposure, col chi2
label define immunosuppression 0"No" 1"Yes"
label values AZA immunosuppression
label values Cyclosporine immunosuppression
label values Everolimus immunosuppression
label values MMF immunosuppression
label values Prednisolone immunosuppression
label values Sirolimus immunosuppression
label values Tacrolimus immunosuppression
total personweeks if Exposure==0
total personweeks if Exposure==1
gen failure=1 if Infection==1 
replace failure=0 if failure==.
stset time, failure(Comp==1) id(hcno) 
stcrreg Exposure, compete(Comp==2 3)
tab Infection sevHMC if Exposure==1
tab Infection sevHMC if Exposure==0
