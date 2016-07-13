function rat_jul_day, year,month,day,hour,min,sec
;   This function calculates the julian day in decimal.

;Revision:
;Change float to double for accuracy
nparams=n_params()

case nparams of 
3: begin
	hour=0.0 
	min = 0.0 
	sec = 0.0
	end
4: begin
	min=0.0 
	sec = 0.0
   end	
5: sec=0.0
else: dummy =0 
endcase

daynum=0.0
ldpmon = intarr(12,2)
ldpmon(*,0) = [0,31,59,90,120,151,181,212,243,273,304,334]
ldpmon(*,1) = [0,31,60,91,121,152,182,213,244,274,305,335]

k=0
if (is_leapyr(year)) then k=1
jday=day+ldpmon((month-1),k)

;daynum=float(hour)/24.0+float(min)/1440.0+float(sec)/86400.0+jday
daynum=double(hour)/24.0+double(min)/1440.0+double(sec)/86400.0+jday
return, daynum
end
