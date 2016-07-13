function rat_gen_yr_axis,start_date,end_date,x_labels

days_yr = [365.0,366.0]
start_yr = fix(start_date)
start_day = (start_date - start_yr)*days_yr(rat_is_leapyr(start_yr))
yr_end = fix(end_date)
start_day = (end_date - end_yr)*days_yr(rat_is_leapyr(end_yr))
n_yr = (end_yr - start_yr)
yr_arr = findgen(n_yr+1) 
yr_arr[yr_arr,yr_arr(0:n_yr-1)+0.5]

stop

case (n_yr) of 

(n_yr < 5) : 		begin
			
				n_ticks = n_yr*2+1

			end

(n_yr >5 and n_yr <10) : begin
				n_ticks = 
				
n_yr>10 : n_ticks =  



