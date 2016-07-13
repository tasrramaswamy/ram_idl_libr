;This function is an extension of histogram in IDL. This function also includes number of values less than
;minimum and number of values less than maximum
function rat_histogram,arr,_extra=_extra,min=min,max=max,idx_min=idx_min,idx_max=idx_max,$
	n_min=n_min,n_max=n_max,append=append,locations=locations,reverse_indices=reverse_indices,$
	_print=_print
	
	if(keyword_set(_print)) then append=1
	hh = histogram(arr,_extra=_extra,min=min,max=max,locations=locations,$
		reverse_indices=reverse_indices)
	diff = locations[1]-locations[0]
	idx_min = where(arr lt min,n_min)
	idx_max = where(arr ge max+diff,n_max) 
	if(KEYWORD_SET(append)) then hh=[n_min,hh,n_max]
	if(KEYWORD_SET(_print)) then begin
		print,'Less than ',locations[0] , hh[0]
		for i = 0 , n_elements(locations)-1 do begin
			print,locations[i],hh[i+1]
		endfor
		print,'Greater than ',locations[i-1],hh[i]
		hh=''
	endif
	return,hh


end

