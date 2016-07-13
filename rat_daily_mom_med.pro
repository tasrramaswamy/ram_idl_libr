;+
;This procedure is modified from rat_daily_moment.pro. This procedure calculates
;median,standard deviation and other statistical quantities with respect to MEDIAN.
;-
pro rat_daily_mom_med ,daynum,a,uniq_days,b, $
	mad=mad,meanabsdev1=meanabsdev1,$
	std_dev=std_dev , sig_val = sig_val ,$
	dev_med = dev_med,n_val =n_val,n_dev_med = n_dev_med,stop1=stop1



n_para =  n_params()
dim_inp = size(arr,/dimensions)
n_dim = n_elements(dim_inp)

n_daynum = n_elements(dim_inp)

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

sig_val_t = temp_arr & dev_med_t = temp_arr & n_dev_med_t = temp_arr
;Reduce time dimesnion for statistical quantities.
out_t = temp_arr[0:n_uniq-1 , *, * ,* ]
std_dev_t = out_t & mad_t = out_t & med_t = out_t
meanabsdev1_t = out_t

for i = 0 , n_uniq-1 do begin
	idx_day = where(daynum eq uniq_days[i],n_scans)
	n_val[i] = n_scans
	if(total(finite(array1[idx_day,*,*,*])) eq 0) then continue
	temp = rat_sig_med(array1[idx_day,*,*,*],dimension=0,$
		std_dev_med=std_dev_med1,meanabsdev1=meanabsdev2,$
		mad=mad1,med=med1,dev_med = dev_med1)
	sig_val_t[idx_day,*,*,*] = temp
	std_dev_t[i, *,*,*] = std_dev_med1
	mad_t[i, *,*,*] = mad1
	med_t[i, *,*,*] = med1
	meanabsdev1_t[i, *,*,*] = meanabsdev2
	dev_med_t[idx_day,*,*,*] = dev_med1
	n_dev_med_t[idx_day,*,*,*] = dev_med1 / med1
endfor
if(n_dim gt 1) then begin
	order_dim_out = sort(order_dim_inp)
	b = transpose(med_t,order_dim_out)
	sig_val = transpose(sig_val_t,order_dim_out)
	mad = transpose(mad_t,order_dim_out)
	meanabsdev1 = transpose(meanabsdev1_t,order_dim_out)
	std_dev_med = transpose(std_dev_t,order_dim_out)
	dev_med = transpose(dev_med_t,order_dim_out)
	n_dev_med_t = transpose(n_dev_med_t,order_dim_out)

endif else begin
	b = med_t
	sig_val = sig_val_t
	mad =mad_t
	manabsdev1 = meanabsdev1_t
	std_dev = std_dev_t
	dev_med = dev_med_t
	n_dev_med = n_dev_med_t
endelse

if(KEYWORD_SET(stop1)) then stop
end
