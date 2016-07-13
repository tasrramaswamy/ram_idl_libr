;+
;This routine prepares the device. 
;If no argument is given , it checks for the current device and uses the same.
; If device is 'X', then it creates window with default colors.
;If device is 'PS', then following conditions are checked.
;	If no UNIT is open, a new file is open with the given filename(default='idl.ps')
;	otherwise following conditions are checked
;		If no ps_name is specified, a new page is created for plotting
;		If same ps_name as current device and APPEND is specified, a new page is created
;		IF ps_name and 
;-
pro rat_refresh_dev,dev_id,PS_name=ps_name, x_name=x_name, x_no=x_no ,$
	append=append,colors_13 = colors_13,qual12=qual12 , qual7=qual7,$
	x_size=x_size,y_size=y_size, ct=ct,orient=orient,port=port
np=n_params()
if(np eq 0) then begin
	;	if(strupcase(!D.name) eq 'X') then dev_id = 0 else dev_id=1
	case strupcase(!D.NAME) of
		'PS':dev_id=1
		'Z':dev_id=2
		else:dev_id=0
	endcase
endif
if (KEYWORD_SET(X_SIZE) eq 0) then x_size=800
if (KEYWORD_SET(y_SIZE) eq 0) then y_size=600

case dev_id of
0: begin	;PLOTTING on SCREEN (X-WINDOWS)
	set_plot,'x'
	if (KEYWORD_SET(ct) eq 0) then ct =39
	if(~Keyword_set(x_no)) then x_no = !d.window+1
	if(~Keyword_set(x_name)) then x_name='IDL '+string(format='(I2)',x_no)
	rat_window,no=x_no,name=x_name,ct=ct,x_size = x_size,y_size =y_size
end
1: begin	;PLOTTING TO PS FILE		
	if (KEYWORD_SET(ct) eq 0) then ct =40
	if (!D.unit eq 0 ) then begin ; NO open PS FIle
		if(~keyword_set(ps_name)) then ps_name='idl.ps'
		make_ps,ps_name,ct=ct,port=port
	endif else begin ; if any PS file is open
	;	stop
		r=fstat(!D.UNIT)
		c_fname = r.name
		if(~keyword_set(ps_name)) then begin
			rat_erase
			loadct,ct
			break
		endif
		
		pos = strpos(c_fname,ps_name)
		if(pos ge 0 and KEYWORD_SET(append)) then rat_erase else begin
			device,/close
			make_ps,ps_name,port=port
			loadct,ct
		endelse
		endelse
	end
2: begin
	set_plot,'Z'
	if (KEYWORD_SET(ct) eq 0) then ct =39
	device,set_resolution=[x_size,y_size]
	loadct,ct
	end
endcase
if(KEYWORD_SET(colors_13)) then rat_load_12ch_colors
if(KEYWORD_SET(qual12)) then rat_load_qual12_colors
if(KEYWORD_SET(qual7)) then rat_load_qual07_colors
home_dir = getenv('HOME')
;loadct,file=home_dir+'/IDL_LIBR/colors/brewer.tbl'

end
