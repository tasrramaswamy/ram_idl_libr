pro rat_stat,arr,fill_val=fill_val,stop1=stop1

if(KEYWORD_SET(fill_val)) then inp = rat_fill_val_nan(arr,fill_val=fill_val) $
	else inp = arr
print,'Total number of values : '+rat_string(n_elements(arr))
fin=total(finite(arr,/Nan)) & fin_per=fin*100.0/n_elements(arr)
if(fin_per lt 0.1) then begin
	print,'Number of Fill or Invalid Values : '+rat_string(fin)
endif else print,'Percent of Fill or Invalid Values (%): '+string(fin_per,form='(F8.3)')
print,'Mean : '+string(avg(inp,/Nan))
print,'Median : '+string(median(inp))
print,'Max : '+string(max(inp,/nan))
print,'Min : '+string(min(inp,/nan))
print,'Std. Dev : '+string(stddev(inp,/nan,/double))
sd = stddev(inp,/nan,/double)
mu = avg(inp,/Nan)
n_sig = lonarr(3)
for i = 1,3 do begin
	limit1 = mu - (i*sd) 
	limit2 = mu + (i*sd)
	hi_limit = max([limit1,limit2]) & lo_limit = min([limit1,limit2])
	temp=where(arr gt lo_limit and arr lt hi_limit,npts)
	n_sig[i-1]=npts
endfor
;idx = where(abs(inp-mu) le sd , n_sig1)
;idx = where(abs(inp-mu) le (2*sd) , n_sig2)
;idx = where(abs(inp-mu) le (3*sd) , n_sig3)
idx = where(finite(inp) eq 1 , n_finite)
n1_sigp = (n_sig[0]/double(n_finite))*100
n2_sigp = (n_sig[1]/double(n_finite))*100
n3_sigp = (n_sig[2]/double(n_finite))*100
print,'Points within 1-sigma (as % of number of finite values) : '+string(n1_sigp,form='(F7.2)')
print,'Points within 2-sigma (as % of number of finite values) : '+string(n2_sigp,form='(F7.2)')
print,'Points within 3-sigma (as % of number of finite values)) : '+string(n3_sigp,form='(F7.2)')
if(KEYWORD_SET(stop1)) then stop
end

