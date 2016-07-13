function rat_ts_slope , xa, ya
	x = xa & y = ya
	n_x = n_elements(x) & n_y = n_elements(y)
	dim_x = size(x,/dimensions) & dim_y = size(y,/dimensions)
	if(n_x ne n_y) then begin
		print,'%%%%%%%%%%%%%%%%%%%%%%%%%'
		print,'ERROR : SIZE OF ARRAYS DONOT MATCH '
		stop
	endif
	if(dim_x[0] eq 1 ) then x = transpose(x)
	if(dim_y[0] eq 1 ) then y = transpose(y)
	sl = dblarr(n_x)
	for i = 0 , n_x-2 do $
		sl[i]= (x[i+1]-x[i]) /(y[i+1]-y[i])
	sl[i]=1.0
	return,sl
end



