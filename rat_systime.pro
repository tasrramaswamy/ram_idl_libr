function rat_systime,year

;+ 
;This function returns system time in yyyymmdd hh:mm:ss format
;-
curr_time = systime(0)
curr_time = strupcase(curr_time)
months=['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP',$
	'OCT','NOV','DEC']
strnum=['01','02','03','04','05','06','07','08','09']
stryr = STRMID(curr_time,3,4,/reverse_offset)
str_mon = strupcase(strmid(curr_time,strlen(curr_time)-5,3,/reverse_offset))
strdate = strmid(curr_time,8,2)
idate = fix(strdate)
if(idate lt 10) then strdate = string(idate,format='(I2.2)')
strtime = strmid(curr_time,12,8,/reverse_offset)
mon = rat_strmon_num(str_mon)
if (mon le 0) then print,'ERROR : Invalid month number'
if (mon le 9) then strmon=strnum(mon-1) else strmon =strcompress(string(mon),/REMOVE_ALL)

ret_str = stryr+strmon+strdate+' '+strtime

return,ret_str
end

