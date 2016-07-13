function rat_ts_ratio , xa
	x = xa 
	n_x = n_elements(x) 
	dim_x = size(x,/dimensions) 
	if(n_x lt 2) then begin
		print,'%%%%%%%%%%%%%%%%%%%%%%%%%'
		print,'Array requires atleast two elements'
		stop
	endif
	if(dim_x[0] eq 1 ) then x = transpose(x)
	sl = dblarr(n_x)
	for i = 0 , n_x-2 do $
		sl[i]= (x[i+1]/x[i]) 
	sl[i]=1.0
	return,sl
end



