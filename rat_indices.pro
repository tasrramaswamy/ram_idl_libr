function rat_indices , arr,ele , stop1=stop1

n_el = n_elements(ele)
idx_out = fltarr(n_el)+!values.F_Nan
for i = 0 , n_el-1 do begin
	m = where(arr eq ele[i] , count)
	if(count gt 0) then idx_out[i] = m[0]
endfor

if(KEYWORD_SET(stop1)) then stop
return,idx_out

end
