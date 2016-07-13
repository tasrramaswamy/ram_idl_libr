;+
;This Function calculates sigma values from median.
;
; Result = rat_sig_med , arr ,std_dev_med=std_dev_med ,meanabsdev1=meanabsdev1,$
;	mad= mad , med =med ,dimension=dimension,dev_med = dev_med,stop1=stop1)
;
;	dev_med = deviation from the median
;-


;Important Note : Array Dimension for this procedure starts with 0.

function rat_sig_med , arr ,std_dev_med=std_dev_med ,meanabsdev1=meanabsdev1,$
	mad= mad , med =med ,dimension=dimension,dev_med = dev_med, $ 
	 norm_dev_med=norm_dev_med,stop1=stop1
;On_Error,2


if(~KEYWORD_SET(DIMENSION)) then d1=-1 else d1 = dimension


n_el = float(total(finite(arr)))

if(n_el eq 0) then begin
	print,'&&&&&&&&&&&&&&&&&&' 
	print,' Error:  NO finite values in array'
	print,'&&&&&&&&&&&&&&&&&&'
	message,level=0,'INPUT ARRAY SHOULD HAVE ATLEAST ONE FINITE VALUE'
endif
if(d1 eq -1) then begin
ret_val = arr
med = median(arr)
diff = (arr - med)
stdmed = sqrt(total((diff ^ 2),/Nan) /(n_el-1))
;if(check_math(/noclear) ne 0) then stop
mad = median(abs(diff))
meanabsdev1= meanabsdev(arr,/median,/nan)
ret_val = (arr - med) / stdmed
std_dev_med = stdmed
;return,ret_val
endif else begin
	n_dim = size(arr,/n_dimensions)
	dim = size(arr,/dimensions)
	med = median(arr,dimension=d1+1) ; TO calculate median along first dimension , use dimension=1
	out_dim = size(med,/dimensions)
	mad = dblarr(out_dim) & stdmed = mad & meanabsdev1 = mad
	;Pad arrays with dummy dimensions so that input array with any number of dimensions
	;	is converted to an array with four dimensions
	case n_dim of
			1:      PAD_ARRAY = reform(ARR ,dim[0],1,1,1)
			2:      PAD_ARRAY = reform(ARR ,dim[0],dim[1],1,1)
			3:      PAD_ARRAY = reform(ARR ,dim[0],dim[1],dim[2],1)
			4:      PAD_ARRAY = ARR
		endcase
	dim_pad_arr = size(pad_array,/dimensions)
	inp_dim_order = indgen(4)
	;Transpose the input (paded) array such that the first dimension is the dimension 
	;across which statistics needs to be evaluated. 
	;For example, if you have 10 samples a day for a time series data and would like to 
	;evaluate statistics for each day, make time dimension as your first dimension.
	if(d1 ne 0) then  begin
		dim1 = rat_1notin2(inp_dim_order,d1)  ; Get all dimensions other than input dimension
		rot_dim_order = [d1,dim1]	; Re-arraging dimensions
		rot_arr = transpose(arr,rot_dim_order)   ;Transposing array to new dimension order
	endif else begin
		rot_arr = pad_array
		rot_dim_order = inp_dim_order
	endelse
	
	dim_rot_arr = size(rot_arr,/dimensions)
	diff_t = dblarr(dim_rot_arr) & ret_val_t = diff_t

	for j = 0 , dim_rot_arr[1]-1 do begin
		for k = 0 , dim_rot_arr[2] -1 do begin
			for l = 0 , dim_rot_arr[3]-1 do begin
				diff1 = rot_arr[*,j,k,l] - med[j,k,l]
				a_diff1 = abs(diff1)
				diff_t[*,j,k,l] = diff1
				n_fin_el = total(finite(diff1))
				stdmed[j,k,l] = sqrt(total(diff1 ^ 2,/nan,/double)/(n_fin_el-1))
				mad[j,k,l] = median(abs(diff1))
				meanabsdev1[j,k,l] = total(a_diff1,/nan)/n_fin_el
				ret_val_t[*,j,k,l] = (rot_arr[*,j,k,l] - med[j,k,l]) / stdmed[j,k,l]
			endfor
		endfor
	endfor
	if(d1 ne 0) then begin ; Transpose output array back to original dimension order
		diff = transpose(diff_t,sort(rot_dim_order))
		ret_val = transpose(diff_t,sort(rot_dim_order))
	endif else begin
		diff =diff_t
		ret_val = ret_val_t
	endelse
	diff = reform(diff)
	ret_val=reform(ret_val)
	mad = reform(mad)
	med = reform(med)
	stdmed = reform(stdmed)
	meanabsdev1 =reform(meanabsdev1)
	
endelse
dev_med = diff
norm_dev_med = dev_med / med
if(KEYWORD_SET(stop1)) then stop
return, ret_val 
end
