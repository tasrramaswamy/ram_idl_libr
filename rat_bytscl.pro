function rat_bytscl,arr,min=min,max=max,top=top,_extra=_extra,$
	stop1=stop1
	if(n_elements(bottom) eq 0) then bottom=0
	if(n_elements(top) eq 0) then top=255
	arr_scl = bytscl(arr,min=min,max=max,top=top-2,_extra=_extra)
	arr_scl=arr_scl+1
	idx_lo = where(arr lt min , Nlow)
	idx_hi = where(arr gt max , Nhi)
	if(Nlow gt 0) then arr_scl[idx_lo]=bottom
	if(Nhi gt 0) then arr_scl[idx_hi]=top
	if(KEYWORD_SET(stop1)) then stop
	return,arr_scl
end

