function rat_order_check ,vector , stop1=stop1
	asc= -1 & dsc = -1 & order = -1
	v = vector
	asc_v = rat_sort(v)
	dsc_v = rat_sort(v,/descending)
	if (array_equal(v,asc_v) eq 1) then begin
		asc=1
		order = 1
	endif
	if (array_equal(v,dsc_v) eq 1) then begin
		dsc=1
		if(order eq -1) then order = 2 else order =3
	endif
	if(KEYWORD_SET(stop1)) then stop
	return,order
end
	


