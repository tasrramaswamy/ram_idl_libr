function rat_period , array,levels,gt_last_val = gt_last_val,stop1=stop1
arr = array
lvl=levels
nl = n_elements(lvl)
pp = lonarr(nl)
;Less than first value
idx = where(arr le lvl[0] , nval)
pp[0]= nval
for i = 1, nl-1 do begin
	idx = where(arr gt lvl[i-1] and arr le lvl[i] , nval)
	pp[i]=nval
endfor
total=nl
idx = where(arr gt rt_last_value(lvl) ,nval)
gt_lastval = nval
if(KEYWORD_SET(stop1)) then stop
return, pp
end
