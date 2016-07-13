pro rat_polyfill,lon,lat,color_arr,skip_arr = skip_arr,res_lat=res_lat,res_lon=res_lon

if(n_elements(skip_arr) eq 0) then skip_arr = make_array(DIMENSION=size(color_arr,/dimensions),/integer)

if(n_elements(res_lat) eq 0) then res_lat=2
if(n_elements(res_lon ) eq 0) then res_lon=2

for i = 0,n_elements(lon)-1 do begin
	for j = 0,n_elements(lat)-1 do begin
		if(skip_arr[j,i] eq 1) then continue
		polyfill,lon[i]+([-1,-1,1,1]*res_lon/2.0),lat[j]+([-1,1,1,-1]*res_lat/2.0),$
			color=color_arr[j,i],/data
	endfor
endfor
end


