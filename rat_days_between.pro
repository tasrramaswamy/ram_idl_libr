function rat_days_between , yr1,jday1,yr2,jday2

c1 =  rat_rev_jul_day(yr1,jday1)
c2 = rat_rev_jul_day(yr2,jday2)

day1 = c1 mod 100
mon1 = (long(c1) /100L) mod 100
day2 = c2 mod 100
mon2 = (long(c2) /100L) mod 100
;stop
days = julday(mon1,day1,yr1) - julday(mon2,day2,yr2)
;print,days
return,days
end

