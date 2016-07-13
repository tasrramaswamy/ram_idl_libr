function rat_get_date,fname
result_fn=''
min_sec='00:00'
file_exists= FILE_TEST(fname,/read)
if file_exists eq 1 then begin
	mon_q = "ls -l "+fname+" | awk '{print $6}'"
	date_q = "ls -l "+fname+" | awk '{print $7}'"
	other_q = "ls -l "+fname+" | awk '{print $8}'"
	spawn,mon_q ,mon_str
	spawn,date_q ,date_str
	spawn, other_q ,other_str
	pos_col = STRPOS(other_str,':')
	if (pos_col ne -1) then  begin
			min_sec=other_str
			sys_time=systime()
			year= strmid(sys_time,3,4,/REVERSE_OFFSET)
            endif else	year =fix(other_str) 
	    mon = rat_strmon_num(mon_str)
	    date=long(date_str)+long(mon)*100+long(year)*10000
	    result_fn=strcompress(string(date),/REMOVE_ALL)+' '+min_sec
endif else result_fn='-1'	    
return,result_fn
end
