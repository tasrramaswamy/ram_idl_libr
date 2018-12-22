pro rat_map_array,arr, lat, lon, min_val, max_val, n_colors, pngfile,$
   _div=_div,format=format,tit=tit

    dev=STRUPCASE(!D.NAME)
    arr_scl = bytscl(arr,min=min_val,max=max_val,top=n_colors,/nan)
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
    if(~KEYWORD_SET(_div)) then rat_brewer_sav else rat_brewer_div,/center
    ;erase,color=255
    ;map_set,/grid,/cont,xmargin=[15,3],ymargin=[2,5],/noborder
    map_set,/grid,/cont,xmargin=[2,5],ymargin=[15,3],/noborder
    plots,lon,lat,psym=2,symsize=.5,color=arr_scl
    MAP_CONTINENTS,/continents
    map_grid,/box_axes
    colorbar_fan,position=poscbar,$
        ncolors=max(arr_scl,/nan)+1,$
        min=min_val,max=max_val,divis=n_colors+1,color=!p.color,$
        format=format
    if (n_elements(tit) ne 0) then xyouts,0.5,0.09,/norm,tit
    if(dev eq 'Z') then rat_z2png,pngfile
    ;stop




end

