function rat_bin_arr , arr ,min=min,max=max,nbins=nbins,binsize=binsize
	if(~KEYWORD_SET(min)) then min = min(arr,/nan)
	if(~KEYWORD_SET(max)) then max = max(arr,/nan)
	if(~KEYWORD_SET(nbins) and ~KEYWORD_SET(binsize)) then begin
		hist=histogram(arr,min=min,max=max,reverse_indices=ri)
	endif
	if(KEYWORD_SET(nbins)) then $ 
			hist=histogram(arr,min=min,max=max,nbins=nbins,reverse_indices=ri)
	if(KEYWORD_SET(binsize)) then begin
			hist=histogram(arr,min=min,max=max,binsize=binsize,reverse_indices=ri)
	endif 
	idx_0 = where(hist eq 0,n_0)
	list1=list()
	for i = 0,n_elements(hist)-2 do begin
			if( ri[i] eq ri[i+1]) then begin
					list1.add,!values.F_Nan
					continue
			endif
			idx_all = ri[ri[i]:ri[i+1]-1]
			list1.add,idx_all
	endfor
	stop
	return,list1
end


