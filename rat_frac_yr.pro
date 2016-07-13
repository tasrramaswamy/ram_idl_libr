
function rat_frac_yr,a,b,yrday=yrday,dnum=dnum

if(KEYWORD_SET(yrday)) then begin
	yr = long(a) / 1000L
	day = long(a) mod 1000L
	time = double(yr) + double(day)/365.25d
	goto,end_pgm
endif
if(KEYWORD_SET(dnum)) then begin
	start_yr = a
	daynum=b
	time = double(start_yr)  + double(daynum)/365.25d
	goto,end_pgm
endif
yr = a
day = b
time = double(yr) + double(day)/365.25d
end_pgm:  return,time
end
