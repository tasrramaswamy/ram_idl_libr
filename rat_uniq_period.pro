;+
;This function calculates periodogram of unique elements in the array.
;E.g. To calculate number of scan for each day give the daynumber array into this 
;routine
;-
;
;## 5/8/12 Added PER keyword to return percentages instead of number
;## 6/1/12 Added MAX keyword to return maximum period only.
function rat_uniq_period,arr , print=print,stop1=stop1,PER=PER,MAX=MAX

	on_error,2
	u_el = rat_uniq(arr)
	if(n_elements(arr) lt 2) then $
		 message,'The array should contain atleast two elements'
	freq = fltarr(n_elements(u_el))
	for i = 0 , n_elements(u_el)-1 do begin
		idx = where(arr eq u_el[i],count)
		if(count ne 0) then freq[i] = count
		if(KEYWORD_SET(print)) then print,u_el[i],count
	endfor
	percent = freq *100.0 /  n_elements(arr)
	if(KEYWORD_SET(PER)) then ret_val = [[u_el],[percent]] else $
		ret_val = [[u_el],[freq]]
	if(KEYWORD_SET(MAX))then ret_val = max(freq)
if(KEYWORD_SET(stop1)) then stop
return,ret_val
end

	
