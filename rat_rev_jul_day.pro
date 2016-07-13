function rat_rev_jul_day, year,jday
;+ This function returns the calendar date(dd-MON-yyyy) of a given 
;julian day( and year).
;-
nparams=n_params()
mm=0 & dd=0 & yyyy=0
ldpmon = intarr(12,2)
ldpmon(*,0) = [0,31,59,90,120,151,181,212,243,273,304,334]
ldpmon(*,1) = [0,31,60,91,121,152,182,213,244,274,305,335]
if (nparams eq 1) then begin 
	curr_time = rat_systime(0)
	jday =year
	year = float(strmid(curr_time,0,4))
endif
lp_yr = 0
if(is_leapyr(year) eq 1) then lp_yr =1
idx=where(jday le ldpmon(*,lp_yr),count)
if(count le 0) then begin
		mm=12
		dd = jday - ldpmon(mm-1,lp_yr)
endif else begin
		mm = idx(0) 
		dd = jday - ldpmon(mm-1,lp_yr) 
endelse

cal_date = 0d
cal_date = double(year)*(10000d)+double(mm)*(100d)+dd
;print,year,mm,dd
;print,cal_date
;stop

return,cal_date
end

