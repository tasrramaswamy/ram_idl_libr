function rat_near_val , array,a,val=val
	n_dim = size(array,/N_DIMENSIONS)
	dim=size(array,/DIMENSIONS)
	m = abs(array - a)
	m_idx = where(m eq min(m),idx1)
	val = array[m_idx]
	return,m_idx
end
