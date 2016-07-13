
function rat_frac_yr_l,a,b,yrday=yrday,yrt=yrt ;,dnum=dnum

;yrt keyword is used when  fractional days are included in yrday.
if(KEYWORD_SET(yrday)) then begin
	yr = long(a) / 1000L
	day = long(a) mod 1000L
	l_yr = is_leapyr(yr)
	time = double(yr) + double(day)/(365d + l_yr)
	goto,end_pgm
endif
if(KEYWORD_SET(yrt)) then begin
	yr = long(a) / 1000L
	day = double(a) mod 1000d
	l_yr = is_leapyr(yr)
	time = double(yr) + double(day)/(365d + l_yr)
	goto,end_pgm
endif
;if(KEYWORD_SET(dnum)) then begin
;	start_yr = a
;	daynum=b
;	time = double(start_yr)  + double(daynum)/365.25d
;	goto,end_pgm
;endif
yr = a
day = b
l_yr = is_leapyr(yr)
time = double(yr) + double(day)/(365d + l_yr)
end_pgm:  return,time
end
