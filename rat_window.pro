pro rat_window,mono = mono , no=no, name = name, ct=ct, $
	x_size=x_size,y_size=y_size,colors_13 = colors_13,$
	qual12=qual12 , qual7=qual7 ,r_colors_13=r_colors_13
set_plot,'x'
device,decomposed =0
if (KEYWORD_SET(no) eq 0 ) then begin
	if(!d.window gt 29) then no=1 else no = !d.WINDOW+1
endif
if ( no gt 29) then begin
	if(!d.window gt 29) then no=1 else no = !d.WINDOW+1
endif
if (KEYWORD_SET(name) eq 0) then name='IDL '+strcompress(string(no),/remove_all)
if (KEYWORD_SET(ct) eq 0) then ct =39
if (KEYWORD_SET(X_SIZE) eq 0) then x_size=800
if (KEYWORD_SET(y_SIZE) eq 0) then y_size=600

case (KEYWORD_SET(mono)) of 
	0: begin
		window,no,colors=255,retain=2,title=name,$
			xsize=x_size,ysize=y_size
		loadct,ct
		end
	else: window,no,colors=2,retain=2,title=name,$
			xsize=x_size,ysize=y_size
endcase
!p.multi=0
!p.title=''
!x.title=''
!y.title=''
!p.position=[0,0,0,0]
!p.charsize=1.0
!y.crange = [0,0]
!x.crange = [0,0]
!y.tickformat =''
!x.ticklen=0
!y.ticklen=0
!x.range=[0,0]
!y.range=[0,0]
if(KEYWORD_SET(colors_13)) then rat_load_12ch_colors
if(KEYWORD_SET(r_colors_13)) then rat_load_12ch_colors,/rev
if(KEYWORD_SET(qual12)) then rat_load_qual12_colors
if(KEYWORD_SET(qual7)) then rat_load_qual07_colors
end
	
