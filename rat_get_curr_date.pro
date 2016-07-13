function  rat_get_curr_date , dummy,MON=MON,YR=YR,DD=DD,MM=mm,$
		TIME=TIME , YYYY=YYYY
;+
;This function returns current date and time in format
;-

STR_TIME = SYSTIME(0)
STR_TIME_FORMAT = STRMID(STR_TIME,11, 9)+STRMID(STR_TIME, 0,11)+$
   	STRMID(STR_TIME,20, 4)
time = STRMID(STR_TIME,11, 9)

mon_str='JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC'
num_str = string(indgen(10),format ='(I2.2)')
yyyy = fix(STRMID(STR_TIME,20, 4))
yr = YYYY mod 100
mon = strmid(str_time,4,3)

pos = strpos(mon_str,strupcase(mon))
mm = fix((pos / 3))+1
dd = fix(strmid(STR_TIME,8,2))
STR_TIME_FORMAT = STRMID(STR_TIME,11, 9)+STRMID(STR_TIME,0,8)+$
	string(dd,format='(I2.2)')+' '+ STRMID(STR_TIME,20, 4)

return,str_time_format

end	
