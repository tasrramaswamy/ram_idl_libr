function rat_runday2yrday, run_day,yr_start
;+ 
;This function converts the running day (and launch date) of the satellite to 
;year and julian day . 
;-
n_days=n_elements(run_day)
days_yr = [365,366]
year=indgen(n_days)
jday=year
max_yrs=max(run_day)/365L+1
poss_yrs = indgen(max_yrs)+yr_start
leap_yrs=is_leapyr(poss_yrs)
poss_days=intarr(max_yrs)+days_yr[leap_yrs[0]]

for j=1,max_yrs-1 do poss_days[j]=poss_days[j-1] + days_yr[leap_yrs[j]]
for i=0,max_yrs-1 do begin
case i of 
0:  idx=where(run_day  le poss_days[0],count)

else:	idx=where(run_day  le poss_days[i] and run_day gt poss_days[i-1],count)
endcase
	 	
if (count gt 0) then begin
year[idx] = poss_yrs[i]
if(i gt 0) then jday[idx]= run_day[idx] - poss_days[i-1] else jday[idx]=run_day[idx]
endif

endfor
val=[[year], [jday]]

return,val
end
