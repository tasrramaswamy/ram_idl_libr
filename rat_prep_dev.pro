pro rat_prep_dev,dev_id,PS_name=ps_name, x_name=x_name, x_no=x_no
case dev_id of
0: begin
	set_plot,'x'
	if(~Keyword_set(x_no)) then x_no = !d.window+1
	if(~Keyword_set(x_name)) then x_name='IDL '+string(format='(I2)',x_no)
	rat_window,no=x_no,name=x_name
   end
1: begin
	if (!D.unit eq 0 ) then begin
			if(~keyword_set(ps_name)) then ps_name='idl.ps'
			make_ps,ps_name
	endif else begin
			if(~keyword_set(ps_name)) then erase else make_ps,ps_name
	endelse
    end

endcase

end
