pro rat_daily_avg, daynum, a,uniq_days,b,$
	day_dim_no=day_dim_no,fill_value=fill_value,$
	sigma_val = sigma_val
; This procedure calculates the daily average values of arrays.
; For multi-dimensional arrays(such as spectral time series arrays), day_dim_no specifies the dimension that represents date(/time).
;Arrays "a through e" are input , "f through i" are output.
On_error,2
n_para =  n_params()
n_ele = (n_para -1)/2
dim_inp = SIZE(a,/DIMENSIONS)
n_dim = n_elements(dim_inp)
If(~KEYWORD_SET(day_dim_no)) then begin
		n_daynum = n_elements(daynum)
		idx = where(dim_inp eq n_daynum,n_idx)
		case n_idx of 
		1 : day_dim_no = idx+1
		0: MESSAGE,'ARRAY Dimensions does not match'
		else: MESSAGE,'Specify dimension of time(days) '$
				+'using "day_dim_no" KEYWORD'
		endcase
endif
;			day_dim_no=1
			
if(n_dim ge 3.0) then begin
		print,'Number of dimensions greater than 2....'
		stop
endif
case day_dim_no of 
1: begin
	inp = a
	if(n_dim eq 2) then n_other = dim_inp(1)
	end
2: begin
	inp = transpose(a)
	if(n_dim eq 2) then n_other = dim_inp(0)
	end
else: begin
	print,'Incorrect Dimensions'
	stop
	end
endcase
if(KEYWORD_SET(fill_value)) then begin
		idx_fill = where(inp eq fill_value,n_fill)
		idx_fill2d = array_indices(inp,idx_fill)
		inp(idx_fill2d(0,*),idx_fill2d(1,*)) =!values.F_Nan
endif 
sort_daynum =daynum(sort(daynum))
uniq_days = sort_daynum(uniq(sort_daynum))
n_uniq = n_elements(uniq_days)
if (n_elements(n_other) eq 0) then begin
	n_other = 0
	out =fltarr(n_uniq) 
endif 	else out = fltarr(n_uniq ,  n_other)
count=fltarr(n_uniq)

	for i=0,n_uniq-1 do begin
		
	idx=where(daynum eq uniq_days[i],n_count)
	case n_other of 
	0: 	begin
		idx_finite = where(finite(inp(idx)) eq 1,n_finite)  
		if (n_finite gt 0)then out(i) = total(inp(idx),/Nan)/n_finite
		end
	else:	begin
		for j=0,n_other -1 do begin
		idx_finite = where(finite(inp(idx,j)) eq 1,n_finite)  
		if (n_finite gt 0)then out(i,j) = total(inp(idx,j),/Nan)/n_finite
		endfor
		end
	endcase
	endfor
case day_dim_no of
1: b=out
 
2:     b = transpose(out)
        
endcase
;stop
end
