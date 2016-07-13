function avg_calc , a
idx = where(finite(a) eq 1,n_fin)
if(n_fin gt 0) then ret = total(a[idx])/n_fin else ret = !values.F_nan
return, ret
end


function rat_avg , arr , max_dev_med = max_dev_med ,max_dev_avg=max_dev_avg,$
	min_dev_med = min_dev_med,min_dev_avg = min_dev_avg,fill_val=fill_val,stop1=stop1

inp = double(arr)
if(KEYWORD_SET(fill_val)) then begin
	idx = where(arr eq fill_val,n_fill_val)
	if(n_fill_val gt 0) then inp[idx] = !values.F_nan
endif
med = median(inp)
avg1 = avg_calc(inp)
dev_med = (inp - med) / med
dev_avg = (inp - avg1) / avg1
if(KEYWORD_SET(max_dev_med)) then begin
	idx1 = where(abs(dev_med) gt max_dev_med,count1)
	if(count1 gt 0) then inp[idx1] = !values.F_Nan
endif

if(KEYWORD_SET(min_dev_med)) then begin
	idx2 = where(abs(dev_med) lt min_dev_med,count2)
	if(count2 gt 0) then inp[idx2] = !values.F_Nan

endif
if(KEYWORD_SET(max_dev_avg)) then begin
	idx3 = where(abs(dev_avg) gt max_dev_avg,count3)
	if(count3 gt 0) then inp[idx3] = !values.F_Nan
endif
if(KEYWORD_SET(min_dev_avg)) then begin
	idx4 = where(abs(dev_avg) lt min_dev_avg,count4)
	if(count4 gt 0) then inp[idx4] = !values.F_Nan
endif
avg2 = avg_calc(inp)
if(KEYWORD_SET(stop1)) then stop
return,avg2
end
	
	
