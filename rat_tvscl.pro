pro rat_tvscl,arr,lon,lat,res_lat=res_lat,res_lon=res_lon,_extra=_extra,$
	min=min,max=max,top=top,fill_val_color=fill_val_color,$
	brewer_ct=brewer_ct,ct=ct,_stop=_stop
	np = n_params()
	
	if(n_elements(res_lat) eq 0) then res_lat=2
	if(n_elements(res_lon) eq 0) then res_lon=2

	img = bytscl(arr,min=min,max=max,top=top)
	if(n_elements(fill_val_color) gt 0) then begin
		img2 = img 
		idx = where(finite(arr) eq 0 , n_finite)
		if(n_finite gt 0) then img[idx] = fill_val_color
	endif
	if(np eq 1) then begin
		lat1 = rat_linspace(-90,90,fix(180/res_lat)+1) & lat2 = shift(lat1,-1)
		lon1 = rat_linspace(-180,180,fix(360/res_lon)+1) & lon2= shift(lon1,-1)
		lat = ((lat1 + lat2)/2)[0:-2]
		lon = ((lon1+lon2)/2)[0:-2]
	endif
	rat_set_map,brewer_ct=brewer_ct,ct=ct,poscbar=poscbar
	rat_polyfill,lon,lat,img,res_lat=res_lat,res_lon=res_lon
	map_continents,/continents
	colorbar_fan,position=poscbar,min=min,max=max,$
		color=!p.color,ncolors=top+1,divisions=divisions
	if(KEYWORD_SET(_stop)) then stop
end
	
