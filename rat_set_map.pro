pro rat_set_map,xsize=xsize,ysize=ysize,charsize=charsize,ct=ct,$
	brewer_ct=brewer_ct,poscbar=poscbar
	dev = strupcase(!D.NAME)
	if(dev ne 'PS') then begin
		if(n_elements(xsize) eq 0) then xsize=1000
		if(n_elements(ysize) eq 0) then ysize=600
	endif

	case dev of 
		'Z':	begin
				device,set_resolution=[w_xsiz,w_ysiz]
				xst=0.15 & yst=0.1

				end
		'X':	begin
				rat_window,x_size=w_xsiz,y_size=w_ysize
				xst= 0.15 & yst=0.08
				end
	endcase
	if(n_elements(ct) gt 0) then loadct,ct
	if(n_elements(brewer_ct)gt 0) then rat_brewer,brewer_ct,/_erase
	if(n_elements(charsize) eq 0) then !p.CHARSIZE=1.4 $ 
			else  !p.charsize=charsize
	 poscbar = [xst,yst,xst+0.7,yst+0.03]
	 map_set,/grid,/cont,xmargin=[5,5],ymargin=[8,3],/noborder
	 MAP_CONTINENTS,/continents
	 map_grid,/box_axes

end
				

