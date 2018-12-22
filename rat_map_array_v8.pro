

pro rat_map_array_v8,arr, lat, lon, min_val, max_val, n_colors, pngfile,$
   format=format,tit=tit,idx=idx,ct=ct, _center=_center, $
   _reverse = _reverse ,stop1=stop1, toz_colors=toz_colors,$
   ler_colors = ler_colors, ai_colors = ai_colors


	keyw_colors = (keyword_set(toz_colors) or $
			      keyword_set(ler_colors) or $	
					keyword_set(ai_colors) )

    dev=STRUPCASE(!D.NAME)
	if (n_elements(idx) eq 0) then idx=0
    if(~KEYWORD_SET(format)) then format='(F6.2)'
	if(~KEYWORD_SET(ct)) then ct = 39
    if(dev eq 'X') then begin
        rat_window,x_siz=1000,y_siz=600
        ;pos=[0.07,0.1,0.1,0.7]
        xst= 0.15 & yst=0.15
    endif else begin
        set_plot,'Z'
        device,set_resolution=[1000,600]
        ;pos = [0.09,0.1,0.12,0.7]
        xst=0.15 & yst=0.15
    endelse
    poscbar = [xst,yst,xst+0.7,yst+0.03]
    !p.charsize=1.4
    ;load_colors
	if (KEYWORD_SET(keyw_colors)) then begin
		if (KEYWORD_SET(toz_colors)) then levels = rat_v8_ozone_colors()
		if (KEYWORD_SET(ler_colors)) then levels = rat_v8_ler_colors()
		if (KEYWORD_SET(ai_colors)) then levels = rat_v8_ai_colors()
		min_val = levels[0]
		max_val = levels[-1]
		n_colors = n_elements(levels)-2
	endif else begin
		ram_divide_ct, ct, n_colors+1, $
		_center=_center, _reverse=_reverse,$
		_extra=_extra
    ;erase,color=255
	endelse

    arr_scl = bytscl(arr,min=min_val,max=max_val,top=n_colors,/nan)
	;Set background color for Nan or Infinity values
	idx_fin = where(finite(arr) eq 0, n_fin)
	if (n_fin gt 0) then arr_scl[idx_fin] = 255

    ;map_set,/grid,/cont,xmargin=[15,3],ymargin=[2,5],/noborder
    map_set,/grid,/cont,xmargin=[2,5],ymargin=[15,3],/noborder
    plots,lon,lat,psym=2,symsize=.5,color=arr_scl
    MAP_CONTINENTS,/continents
    map_grid,/box_axes
    colorbar_fan,position=poscbar,$
        ncolors=n_colors+1,$
        min=min_val,max=max_val,divis=n_colors+1,color=!p.color,$
        format=format
    if (n_elements(tit) ne 0) then xyouts,0.3,0.09,/norm,tit
    if(dev eq 'Z') then rat_z2png,pngfile
    if(KEYWORD_SET(stop1)) then stop




end

