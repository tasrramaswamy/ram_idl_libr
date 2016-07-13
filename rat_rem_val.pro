; If "TRY" keyword is set, then if the function is unsuccessful in reducing
;the COV to the specified value, it returns the input array .
function rat_rem_val , values,thres_stddev,try=try,$
	__verbose=__verbose,stop1=stop1
np = n_params()
if(np eq 1) then thres_stddev=.01
if(size(values,/type) lt 4) then inp = float(values) $
	else inp = values
std_dev = stddev(inp,/nan) /avg(inp,/nan)
cov_inp = std_dev
ctr=0
while(std_dev gt thres_stddev and total(finite(inp)) gt 2) do begin
	avg1 = avg(inp,/nan) 
	sig1 = abs(inp - avg1) / stddev(inp,/nan)
	idx = where(sig1 eq max(sig1,/nan) ,n_match)
	if(n_match gt 0) then inp[idx]=!values.F_Nan else begin
		if(KEYWORD_SET(__verbose)) then begin
			print,'No max value found'
			print,'Max value : ',max(abs(sig1),/nan)
		stop
			break
		endif	
	endelse
	std_dev = stddev(inp,/nan) / avg(inp,/nan)
	ctr=ctr+1
	if(KEYWORD_SET(__verbose)) then print,'Iteration :'+rat_string(ctr),std_dev
	if(ctr gt n_elements(values)) then begin
		if(KEYWORD_SET(__verbose)) then print,'Breaking of infinite loop'
		break
	endif
endwhile
if(KEYWORD_SET(__verbose) and ~KEYWORD_SET(try)) then $
	print,'COV of input, output: ',cov_inp,std_dev

if(keyword_set(stop1)) then stop
;If "TRY" is set,check if the objective of the function is reached.
; if not reached and TRY is set, retrun the original input values for the function
if(KEYWORD_SET(try)) then begin
	if(std_dev gt thres_stddev) then begin
		inp = values
	 	if(KEYWORD_SET(__verbose)) then $
			 print,'COV of input, try ,output: ',cov_inp,std_dev,cov_inp
	 endif else print,'COV of input, output: ',cov_inp,std_dev

endif
return,inp
end
