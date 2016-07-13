function rat_rem_sigma, arr, sig
	inp = arr
	aa= moment(arr,/double,/Nan,sdev=std_dev)

	;	repeat begin
		min = aa - (sig*std_dev) & max = aa + (sig*std_dev)
		idx1 = where(arr lt min or arr gt max , count)
		if (count gt 0) then begin
		temp = rat_fill_val_nan(inp,index=idx1)
		inp=temp
	endif else print,'%% NO value greater than specified limit)'
	
	return,inp

end
