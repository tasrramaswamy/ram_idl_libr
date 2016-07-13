function rat_delete_elements,a,b, idx = idx,COMPLEMENT = COMPLEMENT
;This function deletes all elements contained in b from array a.
;idx indicates the indices of elements b in array a
;COMPLEMENT indicates all indices in array A except for elements in array B

a_copy  =a
b_copy = b
n_a = n_elements(a)
n_b = n_elements(b)
flag = 0
for  i = 0,n_b-1 do begin
	idx1 = where(a eq b(i),count1)
	if flag eq 0 then begin
		flag = 1 
		idx = idx1 
	endif else idx = [idx , idx1]
endfor
idx_other = indgen(n_a)
sort_idx = idx(sort(idx))
for i = 0,n_elements(sort_idx)-1 do begin
	idx2 = where(idx_other ne sort_idx(i), count)
	if (count gt 0) then idx_other = idx_other(idx2)
endfor

;print,idx_other
val = a(idx_other)
COMPLEMENT = idx_other
;stop
return, val
end
