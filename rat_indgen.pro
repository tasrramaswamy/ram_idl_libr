function rat_indgen ,min,max,npts
	np=n_params()
	if(np lt 3) then npts =(max-min+1)
	diff = double(max-min+1)/npts
	qq= indgen(npts) *diff+min
	return,qq
end

