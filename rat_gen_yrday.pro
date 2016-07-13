function rat_gen_yrday , yr1,yr2

;=
;Generate year and day arrays between yr1 and yr2
;
;Revision
;---------
;The function is revised to check for yrdays 
if(yr2 gt 1e6 )then begin
	final_yr = long(yr2)/1000L
	init_yr = long(yr1)/1000L
	range=[yr1 , yr2]
endif else begin
	final_yr = yr2
	init_yr = yr1
endelse
YRS = indgen(final_yr-init_yr+1)+init_yr

for i = 0,n_elements(YRS) -1 do begin
	if i eq 0 then begin
		leap= is_leapyr(YRS[i])
		YEAR_RNG = intarr(365+leap)+YRS[i]
		DAYS_RNG = indgen(365+leap)+1
	endif else begin
		leap= is_leapyr(YRS[i])
		YEAR_RNG = [YEAR_RNG , intarr(365+leap)+YRS[i]]
		DAYS_RNG = [DAYS_RNG, indgen(365+leap)+1]
	endelse
	leap=0
endfor

YRDAY_RNG = double(YEAR_RNG)*1000 + DAYS_RNG 
if(n_elements(range) gt 1) then begin
	idx1 = where(yrday_rng ge range[0] and yrday_rng le range[1] , n_mat)
	if(n_mat gt 0) then yrday_rng = yrday_rng[idx1]
endif
return, yrday_rng
end
