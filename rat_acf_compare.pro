pro rat_acf_compare , fname1,fname2,norm_ratio=norm_ratio,_extra=_extra,$
	stop1=stop1

rat_acf_read,fname1,yr1,day1,dnum1,acf1

rat_acf_read,fname2,yr2,day2,dnum2,acf2

n_dim1 = size(acf1,/n_dimensions)
n_dim2 = size(acf2,/n_dimensions)

if(n_dim1 eq n_dim2) then begin
	yrday1 = long(yr1)*1000L + long(day1)
	yrday2 = long(yr2)*1000L + long(day2)

	rat_common_days,yrday1,yrday2,idx1,idx2

	yrday_com = yrday1[idx1]
	time_com = rat_frac_yr(yrday_com,/yrday)
	case n_dim1 of
		1: begin
			ratio=acf1[idx1]/acf2[idx2] 
			if(KEYWORD_SET(norm_ratio)) then ratio=ratio/ratio[0]
			rat_refresh_dev
			plot,time_com,ratio,_extra=_extra
		end
		2: begin
			ratio = acf1[*,idx1]/acf2[*,idx2]
			if(KEYWORD_SET(norm_ratio)) then ratio=ratio/ratio[*,0]
			rat_plot_13ch_4c,time_com,ratio,_extra=_extra
		end
	endcase

endif
if(KEYWORD_SET(stop1)) then stop
end
