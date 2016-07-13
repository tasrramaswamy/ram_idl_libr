function rat_finite , arr
;+
; This function returns the finite elements in the array
;Warning: It returns a scalar irrespective of its input(vector or scalar)
;-

a= arr
siz1 = size(a)
dim1 = siz1[0]
fin_a = finite(a)
idx_fin = where(fin_a eq 1 , n_finite)
val = a[idx_fin]

return,val

end

