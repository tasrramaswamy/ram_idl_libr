function rat_file_days_old,fname

;+
;This function returns the days between the file was created and
;the current date.
;-
;
cdate = rat_systime()
if(file_test(fname)) then begin
        fdate = rat_get_date(fname)
        fyr = float(strmid(fdate,0,4))
        fmon = float(strmid(fdate,4,2))
        fday = float(strmid(fdate,6,2))
        cyr =   float(strmid(cdate,0,4))
        cmon =  float(strmid(cdate,4,2))
        cday =  float(strmid(cdate,6,2))
        fjday = jul_day(fyr,fmon,fday)
        cjday = jul_day(cyr,cmon,cday)
        days = days_between(fyr,fjday,cyr,cjday)
        endif else days = -1
return,days
end

