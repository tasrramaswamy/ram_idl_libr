function rat_detrend_time , DAY_NO=DAY_NO, IRRAD = IRRAD, AZIM = AZIM ,MIN_AZIM=MIN_AZIM, $
	MAX_AZIM=MAX_AZIM , n_order=n_order,RANGE=RANGE,TIME=TIME, $
	CALC_IRRAD = CALC_IRRAD,stop1=stop

CALC_IRRAD = IRRAD
CALC_IRRAD [*,*]=!values.F_Nan
n_max_azim = n_elements(max_azim) & n_min_azim = n_elements(min_azim)
if(~keyword_set(range)) then begin
	if((n_max_azim ne 1) or (n_min_azim ne 1)) then begin
		print,'%%%%%%%%%%%ERROR %%%%%%%%'
		print,'Enter Diferent TIme ranges for each curves'
		 print,'%%%%%%%%%%%ERROR %%%%%%%%'
		 stop
	endif  ; for n_elements(max_azim)
	check=1
	n_curves=1

endif  else begin ; for ~keyword_set(range)
        siz_range = size(range)
	if(siz_range[2] ne 2) then begin
		range = transpose(range)
		siz_range = size(range)
	endif

        if(n_max_azim ne n_min_azim) then begin
		print,'%%%%%%%%%%%ERROR %%%%%%%%'
		print,'Number of max azimuth angles not equal to number of min azimuth angles'
		print,'%%%%%%%%%%%ERROR %%%%%%%%'
		stop
	endif 
	check =1
	n_curves = n_min_azim

endelse ; ~keyword_set(range)



if(n_curves eq 1) then begin
	idx = where(azim le azim_min and azim ge azim_max ,n_count)
	if(n_count gt 0) then $
		c_fit = poly_fit(day_no(idx) , irrad(idx),n_order , calc_irrad=calc_irrad)
endif else begin ; n_curves eq 1
	c_fit = fltarr(n_curves,n_order)
 	for i = 0,n_curves-1 do begin
		r = [range[0,i] ,range[1,i]]
		idx = where((azim le azim_min and azim ge azim_max) $
	 		and (day_no gt r[0] and day_no gt r[1]),n_count) 
	 	if(n_count gt 0) then begin 
			c= poly_fit(day_no[idx],irrad[idx],n_order,calc_irrad = c_irrad)
			c_fit[i,*] = c
			calc_irrad[idx] = c_irrad
		endif ;n_count gt 0
	endfor
endelse ; n_curves eq 1


if(KEYWORD_SET(stop1)) then stop
return,c_fit


END
