 function rat_range_order_check , vector ,stop1=stop1
	 v = vector & ret_val = -1
	 if(rat_order_check(v) gt 0) then begin
		 v_min = v[0] & v_max = rt_last_value(v)
		 gen_yrday = rat_gen_yrday(v_min,v_max)
		 if(array_equal(v,gen_yrday) eq 1) then ret_val = 1
	 endif
	 if(KEYWORD_SET(stop1)) then stop
	 return,ret_val
 end

