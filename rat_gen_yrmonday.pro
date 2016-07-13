function rat_gen_yrmonday,st_yrmonday,end_yrmonday,stop1=stop1

str_st = string(st_yrmonday,form='(I8)')
str_end = string(end_yrmonday,form='(I8)')
yr_st = fix(strmid(str_st,0,4)) 
mon_st = fix(strmid(str_st,4,2))
day_st = fix(strmid(str_st,6,2))
yr_end = fix(strmid(str_end,0,4)) 
mon_end = fix(strmid(str_end,4,2))
day_end = fix(strmid(str_end,6,2))
st_jday = jul_day(yr_st,mon_st,day_st)
end_jday = jul_day(yr_end,mon_end,day_end)


st_yrday = yr_st*1000L + long(st_jday)
end_yrday = yr_end * 1000L + long(end_jday)
gendays = rat_gen_yrday(st_yrday,end_yrday)
n_days = n_elements(gendays)
genmonyrdays= lonarr(n_days)
for i =0 , n_days-1 do begin
	yr = long(gendays[i])/1000L
	jday = long(gendays[i]) mod 1000L 
	rev_day = rat_rev_jul_day(yr ,jday )
	genmonyrdays[i]= rev_day
endfor

if(KEYWORD_SET(stop1)) then stop
return , genmonyrdays
end
