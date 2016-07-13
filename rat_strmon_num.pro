function rat_strmon_num,mon_str
months='JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC'
mon_str=strcompress(mon_str,/REMOVE_ALL)
mon_str=STRUPCASE(mon_str)
mon_search=strmid(mon_str,0,3)
pos1=STRPOS(months,mon_search)
if (pos1 ne -1)then actual_month=fix(pos1/3)+1 else actual_month=-1
return,actual_month
end
