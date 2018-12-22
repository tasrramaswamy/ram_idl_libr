
function rat_gridded_avg , array , lat , lon ,$
	res_lat=res_lat , res_lon=res_lon ,$ 
	verbose=verbose, stop1=stop1

lat_div = (180d/res_lat)
lat_inter = rat_linspace(-90.,90.,lat_div+1)
lat_avg = (lat_inter + shift(lat_inter,-1))/2d
lon_div=(360d/res_lon)
lon_inter= rat_linspace(-180.,180.,lon_div+1)
lon_avg = (lon_inter + shift(lon_inter,-1))/2d
lat_avg = lat_avg[0:-2] & lon_avg = lon_avg[0:-2]
lon_mid_arr = transpose(rebin(lon_avg,[lon_div,lat_div]))
lat_mid_arr = rebin(lat_avg,[lat_div,lon_div])


v=transpose([[lat],[lon]])
hist1 = hist_nd(v, [res_lat,res_lon] ,min=[-90.0,-180.0],$
;	nbins=[lat_div,lon_div] , reverse_indices=ri)
	max=[90.0-res_lat , 180.0-res_lon] , reverse_indices=ri)

size_hist= n_elements(hist1)

rec = {statistics, N:lonarr(lat_div,lon_div), $
	 average:dblarr(lat_div,lon_div), $
	 sum:dblarr(lat_div,lon_div), $
	 min:dblarr(lat_div,lon_div), $
	 max:dblarr(lat_div,lon_div), $
	 std_dev:dblarr(lat_div,lon_div), $
	 sum_squares:dblarr(lat_div,lon_div), $
	 lat_midpoints:dblarr(lat_div,lon_div), $
	 lon_midpoints:dblarr(lat_div,lon_div), $
	 resolution_lat: 0 , resolution_lon:0 }

N=lonarr(size_hist) 
average=dblarr(size_hist)
sum=dblarr(size_hist)
minval=dblarr(size_hist)
maxval=dblarr(size_hist)
std_dev=dblarr(size_hist)
sum_squares=dblarr(size_hist)
percentiles=list()
empty_arr=[]

 for j = 0 , size_hist-1 do begin
   if (KEYWORD_SET(verbose)) then begin
   PRINT,'================================================='
   PRINT, 'BIN # :',j
   PRINT ,'Latitude Midpoint :' ,lat_mid_arr[j]
   PRINT ,'Longitude Midpoint :' ,lon_mid_arr[j]
   endif
  if(ri[j] ne ri[j+1]) then begin ;data exists in the bin
	   idx = ri[ri[j]:ri[j+1]-1]
	   n_el=n_elements(idx)
	   arr2= (array[idx] ^ 2.0d)
	   average[j]=avg(array[idx],/nan,/double)
	   N[j]=total(finite(array[idx]))
	   std_dev[j]=stddev(array[idx],/nan,/double)
	   sum[j]= total(array[idx],/nan,/double)
	   minval[j]= min(array[idx],/nan)
	   maxval[j]= max(array[idx],/nan)
	   sum_squares[j]= total(arr2 ,/nan ,/double)
	   percentiles.add, cgpercentiles(array[idx])
	   if(KEYWORD_SET(verbose)) then begin
		  ; PRINT ,'Latitude Midpoint :' ,avg(lat[idx],/Nan)
		  ; PRINT ,'Longitude Midpoint :' ,avg(lon[idx],/Nan)
		   PRINT, 'Latitude  Longitude' 
		   foreach ii,idx do $
		   	PRINT ,lat[ii],lon[ii],form='(2(F7.2,3x))'
		   PRINT,'----------------------------------'
	   endif
   endif else percentiles.add,empty_arr  ; no data in the bin
   endfor

;   rec.N = rebin(N , [ lat_div , lon_div ] )
;   rec.average = rebin(average , [ lat_div , lon_div ] )
;   rec.std_dev = rebin(std_dev , [ lat_div , lon_div ] )
;   rec.sum = rebin(sum , [ lat_div , lon_div ] )
;   rec.max = rebin(maxval , [ lat_div , lon_div ] )
;   rec.min = rebin(minval , [ lat_div , lon_div ] )
;   rec.sum_squares = rebin(sum_squares , [ lat_div , lon_div ] )

   rec.N = N 
   rec.average = average 
   rec.std_dev = std_dev 
   rec.sum = sum 
   rec.max = maxval 
   rec.min = minval 
   rec.sum_squares = sum_squares 
   rec.resolution_lat = res_lat
   rec.resolution_lon = res_lon
   rec.lat_midpoints = lat_mid_arr
   rec.lon_midpoints = lon_mid_arr
 
if KEYWORD_SET(stop1) then stop
return ,rec
end 
