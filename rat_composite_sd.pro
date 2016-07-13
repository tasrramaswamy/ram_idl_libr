;Formula is extracted from http://www.burtonsys.com/climate/composite_standard_deviations.html

function rat_composite_sd , Ns,AVGs,STDs,stop1=stop1
	VARs = STDs * STDs
	N = total(Ns,/nan)
	;Error  Sum of Squares
	ESSG = VARS* (Ns-1)
	;Overall Error Sum of Squares
	ESS = total(ESSG,/nan)
	;Grand mean or overall mean
	GM = total(Ns*AVGs,/Nan) / N
	;deviation of group mean from overall grand mean(GM)
	GSS = (AVGs-GM)/Ns
	;Sum of all GSS
	TGSS = total(GSS,/Nan)
	;Grand Variance
	GV = (ESS+TGSS)/(N-1)
if(KEYWORD_SET(stop1)) then stop

return, sqrt(GV)
end
