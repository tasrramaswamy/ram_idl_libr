pro rat_common_yrday,yr1,day1,yr2,day2,sub_a,sub_b,n_common,supress=supress,verbose=verbose
;This function gets the common values in a and b and returns their
;indices in respective arrays

;Revisions:
;09/28/11 Added condition for no common elements(sub_a and sub_b set to -1)

n_yr1 = n_elements(yr1) & n_day1 = n_elements(day1)
n_yr2= n_elements(yr2) & n_day2= n_elements(day2)
if((n_yr1 ne n_day1) or (n_yr2 ne n_day2)) then begin
	print,'%%%%%%    ERROR %%%%%%%%%%%%%%%%%%'
	print,'Dimensions of Year and Day donot match'
	stop
endif
a = yr1*1000d +  day1 & b = yr2*1000d + day2

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
if(KEYWORD_SET(verbose)) then begin
	print,'No of Elements in Array1: '+string(n_a)
	print,'No of Elements in Array 2: '+string(n_b)
	print,'No of Unique Elements:'+string(n_uniq_val)
	print,'No of Common Elements:'+string(n_common)
;	stop
	endif
end
