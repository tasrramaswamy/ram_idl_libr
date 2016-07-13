;+
;This procedure is modified from rat_daily_avg.pro. This procedure also calculates
;average,standard deviation and other statistical quantities.
;-

pro rat_daily_moment, daynum, a,uniq_days,b,$
	day_dim_no=day_dim_no,fill_value=fill_value,$
	std_dev = std_dev , kurt=kurt,var=var,n_val = n_val,$
	mdev=mdev , middle=middle

; This procedure calculates the daily average values of arrays.
; For multi-dimensional arrays(such as spectral time series arrays), day_dim_no specifies the dimension that represents date(/time).

; middle KEYWORD will calulate the median of the array across the time dimension
;Changed from rat_moment1 to rat_moment2
;On_error,2
n_para =  n_params()
n_ele = (n_para -1)/2
dim_inp = SIZE(a,/DIMENSIONS)
n_dim = n_elements(dim_inp)

;Check if dimensions match 

n_daynum = n_elements(daynum)
idx_m = where(dim_inp eq n_daynum,n_idx)
if(n_idx eq 0) then begin
		print,''
		print,'-------------------------------'
		print,'WARNING : RAT_DAILY_MOMENT.PRO'
		print,'---------------------------------'
		print,'Dimensions of Day number(time) not found in averaging ARRAY'
		print,''
endif
If(~KEYWORD_SET(day_dim_no)) then begin
		case n_idx of 
		1 : day_dim_no = idx_m+1
		else: MESSAGE,'Specify dimension of time(days) '$
				+'using "day_dim_no" KEYWORD'
		endcase
endif
;			day_dim_no=1
			
if(n_dim ge 3.0) then begin
		print,'Number of dimensions greater than 2....'
		stop
endif

;index starts at 0 in IDL, so offset dimsension number by 1
day_dim_no = day_dim_no -1
;Rearrange the dimensions of input array so that the first dimension is time(daynumber).
;All other dimensions are not altered
;Suppose the given array is of dimensions [m,n,p,q,r] and to be averaged along dimension "p"
; then the reversed array will be of dimensions [p,m,n,q,r]

if(n_dim gt 1) then begin
	order_dim_inp = indgen(n_dim)
	idx_other = rat_1notin2(order_dim_inp,day_dim_no)
	idx_other = fix(idx_other)
	order_dim_rev = [day_dim_no,idx_other]
	array1 = transpose(a,order_dim_rev)
endif else array1 = a


uniq_days = rat_uniq(daynum)
n_uniq = n_elements(uniq_days)
n_val = lonarr(n_uniq)
temp_arr = rat_create_arr_size(array1,type="double")

;Reduce time dimesnion.
out_t = temp_arr[0:n_uniq-1 , *, * ,* ]
std_dev_t = out_t & kurt_t=out_t & var_t = out_t & skew_t = out_t
mdev_t =out_t & middle_t = out_t

for i = 0 , n_uniq-1 do begin
	idx_day = where(daynum eq uniq_days[i],n_scans)
	n_val[i] = n_scans
	temp = rat_moment2(array1[idx_day,*,*,*],0,kurt=kurt1,$
		var=var1,std_dev=std_dev1,skew = skew1,mdev = mdev1)
	kurt_t[i,*,*,*] = kurt1
	std_dev_t[i,*,*,*] = std_dev1
	var_t[i,*,*,*] = var1
	skew_t[i,*,*,*] = skew1
	out_t[i,*,*,*] = temp
	mdev_t[i,*,*,*] = mdev1
	middle_t[i,*,*,*] = median(array1[idx_day,*,*,*],dimension=1)
endfor

;Rearrange the dimensions of output arrays to match with the original array.
if(n_dim gt 1) then begin
	order_dim_out = sort(order_dim_inp)
	b = transpose(out_t,order_dim_out)
	kurt =  transpose(kurt_t,order_dim_out)
	skew = transpose(skew_t,order_dim_out)
	std_dev = transpose(std_dev_t, order_dim_out)
	var =transpose(var_t,order_dim_out)
	mdev = transpose(mdev_t,order_dim_out)
	middle = transpose(middle_t,order_dim_out)
endif else begin
	b = out_t
	kurt = kurt_t
	skew = skew_t
	var = var_t
	std_dev = std_dev_t
	mdev = mdev_t
	middle = middle_t
endelse




if(KEYWORD_SET(stop1)) then stop
end
;------------------------------------------------------------------------




pro dummy

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
