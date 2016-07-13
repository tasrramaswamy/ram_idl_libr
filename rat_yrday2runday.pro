function rat_yrday2runday, yrday,launch_yr , stop1=stop1
;+ 
;This function converts yrday(year and julian day) to satellite running day.
;Day1 for running day is the first day on the launch year.
;
;-
np = n_params()
if(np eq 1) then launch_yr = long(yrday[0]) / 1000L
n_el = n_elements(yrday)
runday = dblarr(n_el)
yr = long(yrday) / 1000L
day = long(yrday) mod 1000L
for i = 0L, long(n_el)-1 do begin
	runday[i] = rat_days_between(yr[i],day[i],launch_yr,1) + 1
endfor
if(KEYWORD_SET(stop1)) then stop
return,runday
end
