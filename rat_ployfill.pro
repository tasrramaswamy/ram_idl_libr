pro rat_polyfill,lon,lat,color_arr,skip_arr = skip_arr,res_lat=res_lat,res_lon=res_lon

if(n_elements(skip_arr) eq 0) then skip_arr = make_array(DIMENSION=size(color_arr,/dimensions),/integer)+1


for i = 0,179 do begin
	for j = 0,89 do begin
		if(skip_arr[j,i] eq 0) then continue
		polyfill,lon[i]+[-1,-1,1,1],lat[j]+[-1,1,1,-1],color=color_arr[j,i],/data
	endfor
endfor
end


