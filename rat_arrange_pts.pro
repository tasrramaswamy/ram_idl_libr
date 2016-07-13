function rat_arrange_pts , values,$
	stop1=stop1

n_val = n_elements(values)
type = size(values,/type)
arr = make_array([n_val,n_val],type=type)
foreach val,values,idx do $
	arr[idx,*]=values - val

return,arr


end
