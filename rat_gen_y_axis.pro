function rat_gen_y_axis ,arr , pres
	np = n_params()
	if(np eq 1) then pres=100
	max1 = max(arr)
	min1 = min(arr)
	temp1 = ceil(max1* pres) & temp1 = float(temp1)/pres
	temp2 = floor(min1*pres) & temp2 = float(temp2) /pres
	ret_val = [temp2,temp1]
	return,ret_val
end
