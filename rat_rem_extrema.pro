function rat_rem_extrema , arr, sig
	inp = arr
	aa= moment(arr,/double,/Nan,sdev=std_dev)

	;	repeat begin
		thresh = std_dev*sig
		idx1 = where(arr gt thresh , count)
		if (count gt 0) then begin
		temp = rat_fill_val_nan(inp,index=idx1)
		inp=temp
	endif else print,'%% NO value greater than specified limit)'
	
	return,inp

end
