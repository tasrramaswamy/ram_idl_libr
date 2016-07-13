pro rat_print_clusters , val ,$
	_extra=_extra

n_val = n_elements(val)
CLUSTERS = CLUSTER_TREE(val,linkdistance, _extra=_extra)

foreach elem,clusters,jj do begin
	if(elem[0] lt n_val and elem[1] le n_val) then $
	print,elem[0],elem[1],linkdistance ,val[elem[0]],val[elem[1]]  else $
	 print,elem[0],elem[1],linkdistance
	
end

end
