function rat_scan_stat ,irrad,day ,day_dim_no = day_dim_no

;Check consistency of arrays
n_dim = size(irrad,/n_dimensions)
dim = size(irrad,/dimensions)
n_days = n_elements(day)
u_day = rat_uniq(day)
n_u_days = n_elements(u_day)

if(n_dim gt 2) then  MESSAGE,'ARRAY Dimensions greater than 2'

if(n_dim eq 1) then begin 
	dev_avg = fltarr(dim) & dev_med = dev_avg
	per_dev_avg = dev_avg & per_dev_med = dev_avg
	for i = 0 , n_u_days-1 do begin
		idx = where(day eq u_day[i], n_pts)
		inp = rat_finite(irrad[idx])
		
		n_fin = n_elements(inp)
		if(n_fin gt 1) then begin
			avg1[i] = avg(inp,/Nan)
			med1[i] = median(inp)
			dev_avg[idx] = irrad[idx] - avg1
			dev_med[idx] = irrad[idx] - med1
			per_dev_avg[idx] = (irrad[idx] - avg1) / avg1
			per_dev_med[idx] = (irrad[idx] - med1) / med1

		endif

	endfor
endif

	

and ~KEYWORD_SET(day_dim_no)) then begin
	idx = where(dim eq n_elements(day) , n_idx)
	case n_idx of
                1 : day_dim_no = idx+1
                0: MESSAGE,'ARRAY Dimensions does not match'
                else: MESSAGE,'Specify dimension of time(days) '$
                                +'using "day_dim_no" KEYWORD'
        endcase
endif

u_day = rat_uniq(day)






return,stat
end
