/*
Group 2 - Paper 7
Long Tran
Aaryan Kaphley
Luka Agulashvili
"Do Workplace Smoking Bans Reduce Smoking?"
December 13rd, 2019
*/

clear
set more off
capture log close
graph drop _all

log using Analysis.log, replace
use ..\Data\Smoking.dta

graph bar smoker, by(smkban) blabel(total) name(Figure1)

ssc install outreg2
reg smoker smkban, robust
outreg2 using Analysis.xls, replace

reg smoker smkban c.age##c.age black hispanic female, robust
outreg2 using Analysis.xls, append

reg smoker smkban c.age##c.age black hispanic female hsdrop hsgrad colsome colgrad, robust
outreg2 using Analysis.xls, append

probit smoker smkban, robust
margins, dydx(*) atmeans
outreg2 using Analysis.xls, append

probit smoker smkban c.age##c.age black hispanic female, robust
margins, dydx(*) atmeans
outreg2 using Analysis.xls, append

probit smoker smkban c.age##c.age black hispanic female hsdrop hsgrad colsome colgrad, robust
margins, dydx(*) atmeans
outreg2 using Analysis.xls, append


save ..\Data\Smoking.dta, replace
log close
exit
