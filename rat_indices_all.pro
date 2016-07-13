;+
;This function returns all indices of elements in the array, 
;	inculding duplicate (items occuring more than one occurancr)indices.
;This function has been tested only for one dimensional arrays.
;-
; CAUTION :
; 	DO NOT use this function unless necessary. If any elements are missing in the array
;		the function might not alert you.
function rat_indices_all , arr,ele , stop1=stop1

n_el = n_elements(ele)
idx_out = !values.F_Nan
k=0
for i = 0 , n_el-1 do begin
	m = where(arr eq ele[i] , count)
	if(count gt 0) then idx_out = [idx_out,m]

endfor

if(total(finite(idx_out)) gt 1) then idx=rat_finite(idx_out) $ 
	else idx = !values.F_nan
if(KEYWORD_SET(stop1)) then stop
return,idx

end
