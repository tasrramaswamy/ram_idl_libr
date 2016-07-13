pro rat_common_days,a,b,sub_a,sub_b,n_common,supress=supress,verbose=verbose,$
	order=order,miss_elements=miss_elements,miss_indices=miss_indices,$
	stop1=stop1

;This function gets the common values in a and b and returns their
;indices in respective arrays

;Revisions:
;09/28/11 Added condition for no common elements(sub_a and sub_b set to -1)
;09/28/12 Added ORDER keyword.  Checks if all elements in array A are in array B.
n_a = n_elements(a)
n_b = n_elements(b)
n_check = min([n_a,n_b])
all_val = [a,b]
uniq_val = rat_uniq(all_val)
n_uniq_val = n_elements(uniq_val)
n_common=0
sub_a = indgen(n_uniq_val) & sub_b = sub_a
for i =0 , n_uniq_val -1 do begin
	idx_a = where(a eq uniq_val[i], count_a)
	idx_b = where(b eq uniq_val[i], count_b)
;	print,'count_a'+string(count_a)
;	print,'count_b'+string(count_b)
	if( (count_a eq 1) and (count_b eq 1)) then begin
		sub_a[n_common] = idx_a[0]
		sub_b[n_common] = idx_b[0]
		n_common = n_common+1
	endif
;	if(i mod 10 eq 0) then stop
endfor

if(n_common eq 0) then begin
	sub_a = -1 & sub_b = -1
endif else begin
	sub_a = sub_a(0:n_common-1) 
	sub_b = sub_b(0:n_common-1)
endelse

if(KEYWORD_SET(sort)) then begin
	temp_idx=rat_sort(sub_a)
	if(temp_idx[0] ne -1) then begin
		temp = a[temp_idx]
		if(array_equal(temp,a) ne 1) then begin
			miss_elements = rat_1notin2(a,temp)
			miss_indices = rat_indices(a,temp)
		endif
	endif
endif
if(KEYWORD_SET(verbose)) then begin
	print,'No of Elements in Array1: '+string(n_a)
	print,'No of Elements in Array 2: '+string(n_b)
	print,'No of Unique Elements:'+string(n_uniq_val)
	print,'No of Common Elements:'+string(n_common)
;	stop
	endif
if(KEYWORD_SET(stop1)) then stop

end
