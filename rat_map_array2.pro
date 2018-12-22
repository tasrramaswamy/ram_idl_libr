pro color_setup, idx=idx,n_colors=n_colors, $
	brewer_type = brewer_type, $
	_reverse=_reverse, center=center,$
	_extra=_extra
	
	 if(n_elements(idx) eq 0) then idx=0       
	  if(n_elements(n_colors) eq 0) then n_colors=9 

	seq=[[140,81,10],$
		[191,129,45],$
		[223,194,125],$
		[246,232,195],$
		[245,245,245],$
		[199,234,229],$
		[128,205,193],$
		[53,151,143],$
		[1,102,94]]
	;rat_brewer,36
	;tvlct,r,g,b,/get

   if(~KEYWORD_SET(brewer_type)) then brewer_type=1
	case brewer_type of
		1: begin & seq = 1 & div =0 & qual=0  & end
		2: begin & seq = 0 & div =1 & qual=0  & end
		3: begin & seq = 0 & div =0 & qual=1  & end
		endcase

	seq = rat_get_brewer_colors(n_colors+1,idx, seq=seq, div=div, qual=qual,$
		_extra=_extra)
	r = bytarr(256) & g = r & b=r
	r1 = reform(seq[0,*]) & g1=reform(seq[1,*]) & b1=reform(seq[2,*])
	;stop
	n1 = n_elements(r1)
	if(KEYWORD_SET(_reverse)) then begin
		r1 = reverse(r1) & g1=reverse(g1) & b1 = reverse(b1)
	endif

	r[0:n1-1]=r1 & g[0:n1-1]=g1 & b[0:n1-1]=b1

	r[255]=255 & g[255]=255 & b[255]=255
	r[254]=0  & g[254]=0 & b[254]=0
	r[251]=130 & g[251]=130 & b[251]=130

	;center would create a grey color in the center
	; Number of colors donot exceed 11. 
	;20 is random upper limit to shift colors. 
	 if KEYWORD_SET(center) then begin

			ctr = ceil(n1/2) 
			r0 = r & g0=g  & b0=b
			r[ctr+1:20]= r0[ctr:19] 
			g[ctr+1:20]= g0[ctr:19] 
			b[ctr+1:20]= b0[ctr:19] 
			;r[ctr]=130 & g[ctr]=130 & b[ctr]=130
			;r[ctr]=170 & g[ctr]=170 & b[ctr]=170
			r[ctr]=220 & g[ctr]=220 & b[ctr]=220
	endif
	TVLCT,r,g,b
	!p.background=255
	!p.COLOR=254
	erase
end


pro rat_map_array2,arr, lat, lon, min_val, max_val, n_colors, pngfile,$
   format=format,tit=tit,idx=idx,brewer_type=brewer_type, center=center, $
   _reverse = _reverse ,stop1=stop1
;type =1 sequential brewer colors
;type =2 divergent brewer colors
;type =3 qualitattive colors




    dev=STRUPCASE(!D.NAME)
	if (n_elements(idx) eq 0) then idx=0
    arr_scl = bytscl(arr,min=min_val,max=max_val,top=n_colors,/nan)
	;Set background color for Nan or Infinity values
	idx_fin = where(finite(arr) eq 0, n_fin)
	if (n_fin gt 0) then arr_scl[idx_fin] = 255
    if(~KEYWORD_SET(format)) then format='(F6.2)'
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
    color_setup,idx=idx, n_colors=n_colors, brewer_type=brewer_type, $
		center=center, _reverse=_reverse,$
		_extra=_extra
    ;erase,color=255
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

